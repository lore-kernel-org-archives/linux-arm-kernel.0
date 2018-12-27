Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A55C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:56:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51C320874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dry7Kt0C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYHQrOmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51C320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2p3zhm64RcxvEOLeiz8/dx7kibHRGcfh+HETTYrEm3I=; b=Dry7Kt0C0pBQcU
	QJt9NiEMzxwaA6aIwNyNwg8ifinvsLTeOMTGcSBCFSsX4mQJ0Dsi90U5NXbEleFq2djyD3hUu1Yy+
	LeYvxFYFbXuGu/bH1xwNmVGDiOvm1PTmx6QmfO558Yz4oNrFUhbVpetijN+7JQlyivn+Akaf+lxk3
	tyYfR04UjKxcENmlq2sIpkzKs1g2DRKhRmk7z58UrOQx7+gTYxtL9viMPGj0DTnWUnUrXXyv9f/YM
	7OouMce1MIs+IUfrgCfefnmP0cBLGkOBdPskjdp9oTZadLgJjPuCL/JOti5H2+kZCKqidjdbz+4Je
	tDJYX1X9zgAUfoFVAMyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcX5R-0008Lj-Jv; Thu, 27 Dec 2018 14:56:37 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcX5N-0008Ks-SM
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 14:56:35 +0000
Received: by mail-qk1-x744.google.com with SMTP id q1so10914306qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B1+FmvZXnUqqvWdNdU8jnu2ftZC3qkcxSQR84GGlPnk=;
 b=DYHQrOmVjRhU/96m9z85JNZPU7I3aev5+tJYC7upN5GBC+tIGiH+QMkNq6zO4viIeV
 W17JT2SXBN803hnhGW30ut60E1zH6LQ0IcywUwLDbT07g6l7/XlzEjvQZEeSAXGwDFtq
 jqF162MWlt3LAkhSWXTSaaLsxIjndhfCZwGtd1J26/1t0W/+BIkkG3Yj5WvkS4uiV1He
 OqvETd87PCibwQ0g/Rf1NTXy+sTpezd+UxUOVh3vzMAiXL/ogzwtOELPhzN6YAGLliGY
 jqTAEXAbtBjN1LMBhHFlEWQtSSrJQO0JqI0eLBNnmoFyO6oj1Q1ouYzFeIhqjRIxloJl
 zwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B1+FmvZXnUqqvWdNdU8jnu2ftZC3qkcxSQR84GGlPnk=;
 b=MvJ4SDmUEi7IxZN1rx9YIwQmQkLK5DfntjG4ZgqRXtw/7VyBr83xvhKmPI0LhzNtRa
 908VSS1A5t42p6lwEyj+9D0RoB5yFM57iW8RFHHmhzejZ8j/P9qfS47QRDZAD6aayaQW
 PpLfpF6B3zO4roeplMg/IEwYQEkkDwDOPVqIrfCYqLBzjW6tGteAtfZ94VRO1YdBSRCF
 R0czBpYbQKMdA0Oy2w33stZ/zB1cWEFV1TJkx+wXK/9V5M3n8e0dulSYdeZMGgi6E9yy
 wmHyqcuGgVUquJ9GHijTZhV/I6idxt7sGQOplzS9MrxUSvhSJ8BmDBlaTmetMdkPWHP+
 BUyA==
X-Gm-Message-State: AJcUukeewDWrb4JozIllpJ0MjDb40cgnfTDIb2M90foVMwJGNC34a3Ol
 msWP0POLyowaYdIgpTvnZDigKjqfNrKmpj/ACa8=
X-Google-Smtp-Source: ALg8bN6VfblYnkztEanWXOEq431OCKsItGipVM8N2LQkZUPWn4fY+UxEjwes/D4yliDdPE0zxffxCBJrczk0l6gJdEg=
X-Received: by 2002:ae9:dec5:: with SMTP id
 s188mr21550788qkf.127.1545922582209; 
 Thu, 27 Dec 2018 06:56:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1528819790.git.dolinux.peng@gmail.com>
 <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
In-Reply-To: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 27 Dec 2018 22:56:10 +0800
Message-ID: <CAErzpmv94LHULidn4n-ChgeJkXqc=Z1Zf-DaanBJE1iFpRe_xg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro
To: catalin.marinas@arm.com, will.deacon@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_065633_922934_9420C1A1 
X-CRM114-Status: GOOD (  16.05  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jun 13, 2018 at 9:15 AM Peng Donglin <dolinux.peng@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
> ---
>  arch/arm/mm/ptdump_debugfs.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index be8d87b..79002fe 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -11,18 +11,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>         ptdump_walk_pgd(m, info);
>         return 0;
>  }
> -
> -static int ptdump_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, ptdump_show, inode->i_private);
> -}
> -
> -static const struct file_operations ptdump_fops = {
> -       .open           = ptdump_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ptdump);
>
>  int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>  {
> --
> 2.7.4
>

any suggestion?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
