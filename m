Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A908C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:26:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A34920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bF/gtli0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nnYtZQKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A34920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jaa3G11ZhE0o9yx+0QX+1ZGMiaCoB1IW2yV3VEi/Cpk=; b=bF/gtli0Fen18b
	3qQzaCHTBFzRWW/f23YpN018cMtTUHkmInemWwFjRX5FzwbmTOPlRvOROtDFgU1bBJ5fQrb9UOAdJ
	a+d2WLVUg8TkPJ0tL7T9cbuJ0PPIn3PoLlnIW0AeE6jCwZ1owjTwzNJFA1Z+yrvLhRbwviiSdSj+H
	xwD5mqGEeCGxaX5rmPCIJpbxOUzJCXIhaizLeBW2Fw4DbkpKczx36AP1fQiTNZ2B+3yikMuXZNMFf
	jvRF+LzFMHY3Ohj82emWP+02GS1VZU+kIgvtJ2cz3T2XHtVYxg213imXVgO5yV8Qam58zhs9uIwJj
	XaDya5zgHrJSoQnoxTFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm3Ym-0005i9-2D; Tue, 22 Jan 2019 21:26:16 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm3Yi-0005hl-1C
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 21:26:13 +0000
Received: by mail-vs1-xe41.google.com with SMTP id v205so16990vsc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qA73U3orqts/aQvhT/E9hNnoUEIPSLYn2QJd+UKDOHA=;
 b=nnYtZQKIEw2X+lcZ7kxyFOE1X6P+2PGFEMJ/kFQKu+qPYt5cDrw9QYFujLbhzq/H5N
 ixJpF8CVtwbN/n/fiVb5Z68y7iUVBapOuCjDbmz5NxPlOY9/Dxgm8BLLv/R+h1XC5cNL
 cEjSCkCGm6EnG0T8KY3vRbxOOQ3ncK9o1HsJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qA73U3orqts/aQvhT/E9hNnoUEIPSLYn2QJd+UKDOHA=;
 b=b/pRU/GszH3/3uql3SIsKMjGs4r6mSiTF4D2gDmnaP9bdE6TXuGfe7xzSDdyEvscCF
 a/aRkvqUOAgyP2fmWJ6WlS7lkfQTBsfwxD/UPHd3mpMKXb941h2K0XrPCvwy17V/M2pC
 oIybKazK013QrXp4HaZ9/C1ArBgS4Zme1kA987n5es4CQSM4/ModjQ5YWM9nIPCQl0Fd
 AP5x8yMkjgZ3K86YanNiu3BHAM7ymfrH3Bdo98V9b5FcP726QhOVZWKi9liYa5SmDpSE
 9p4f6HJgSeHYJF44xdyvbORM87HhuPHHlzsjudD4CAIV8YD7FxPTzZiilmt5530pXjbB
 g03w==
X-Gm-Message-State: AJcUukfzGgwtLq1X2RmJ44pzkw/8LJWz80v1DUK6/w+bePjr0RwDZytq
 hkbJYSBfFthrbjEe2WE3eJGQvvEyMr0=
X-Google-Smtp-Source: ALg8bN6PcFqUKCtEvMRt4nFumo9A1hd7F11QlNNKrbv6WrArnQWUv95oeArT/D/pdMjbIdbOJqcRvQ==
X-Received: by 2002:a67:4985:: with SMTP id d5mr14839158vsg.41.1548192369732; 
 Tue, 22 Jan 2019 13:26:09 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com.
 [209.85.217.50])
 by smtp.gmail.com with ESMTPSA id e67sm24668489vsd.32.2019.01.22.13.26.07
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 13:26:08 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id x28so15620815vsh.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 13:26:07 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr14586369vss.172.1548192366962; 
 Tue, 22 Jan 2019 13:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
 <20190122144114.9816-3-gregkh@linuxfoundation.org>
In-Reply-To: <20190122144114.9816-3-gregkh@linuxfoundation.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 23 Jan 2019 10:25:53 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJPyKwM3E=-pnRBJ0NCb4kMB7EtLdS-+5khE76qnEhcdQ@mail.gmail.com>
Message-ID: <CAGXu5jJPyKwM3E=-pnRBJ0NCb4kMB7EtLdS-+5khE76qnEhcdQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: dump: no need to check return value of
 debugfs_create functions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_132612_074165_7A968082 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: Kevin Hilman <khilman@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>,
 Jinbum Park <jinb.park7@gmail.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 3:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Jinbum Park <jinb.park7@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Do you mean that it bubbles up to an initcall, and the return value is
meaningless there? This seems fine to me...

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/include/asm/ptdump.h | 9 +++------
>  arch/arm/mm/dump.c            | 4 ++--
>  arch/arm/mm/ptdump_debugfs.c  | 8 ++------
>  3 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/include/asm/ptdump.h b/arch/arm/include/asm/ptdump.h
> index 3ebf9718288d..0c2d3d0d4cc6 100644
> --- a/arch/arm/include/asm/ptdump.h
> +++ b/arch/arm/include/asm/ptdump.h
> @@ -21,13 +21,10 @@ struct ptdump_info {
>
>  void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
>  #ifdef CONFIG_ARM_PTDUMP_DEBUGFS
> -int ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> +void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>  #else
> -static inline int ptdump_debugfs_register(struct ptdump_info *info,
> -                                       const char *name)
> -{
> -       return 0;
> -}
> +static inline void ptdump_debugfs_register(struct ptdump_info *info,
> +                                          const char *name) { }
>  #endif /* CONFIG_ARM_PTDUMP_DEBUGFS */
>
>  void ptdump_check_wx(void);
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 084779c5c893..eb385a500ed0 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -450,7 +450,7 @@ void ptdump_check_wx(void)
>  static int ptdump_init(void)
>  {
>         ptdump_initialize();
> -       return ptdump_debugfs_register(&kernel_ptdump_info,
> -                                       "kernel_page_tables");
> +       ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> +       return 0;
>  }
>  __initcall(ptdump_init);
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index be8d87be4b93..598b636615a2 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -24,11 +24,7 @@ static const struct file_operations ptdump_fops = {
>         .release        = single_release,
>  };
>
> -int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
> +void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>  {
> -       struct dentry *pe;
> -
> -       pe = debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
> -       return pe ? 0 : -ENOMEM;
> -
> +       debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
>  }
> --
> 2.20.1
>


-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
