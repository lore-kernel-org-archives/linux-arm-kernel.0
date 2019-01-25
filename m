Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DCDC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:25:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621E12133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LvXY3d8x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YupNbHs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621E12133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0X6KryklzYh02J02RgqVpaDSQ4W+DYXl4gVvo3FZfV8=; b=LvXY3d8xsHzsGr
	ZSZB98ZW/5pFL6H14Nj1QDYYLxM1WkimhPTqGjR+xyecXYVBWgxr6pLcflNyXpQ8MaQaqMFdLXpsT
	TKd2pldfNm1YZfKPOgKz4Q603FXtnIUj9rJLPSVZ931zr9iH7fjCFhCkfy1CFr1sr26EBjpcNoHNr
	S4LLU5nFEoBpSQUyklejZqn1Lzh2F5E4xTYhjORbf41BP2r7IWm3THc0GmCpQ5CG4hLmK7YN195FN
	Ki3t3DfK4nE5LTmot3wesh5K74Sje8p1PlD+6rtAFzfwHkeUCy06UCCwVQ+nYm4GAfWHbPidVgScA
	J2ShoKFtm8BfTT6N2yvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmuvY-0000mZ-M9; Fri, 25 Jan 2019 06:25:20 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmuvV-0000lz-I0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 06:25:18 +0000
Received: by mail-lf1-x142.google.com with SMTP id n18so6119350lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 22:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aWkGNsj9H+PPXdmDM8jphreLemaKpKVhG6fjRtFnO8Q=;
 b=YupNbHs7iQOuXsIbeTOXEVnZWfkYovxF20NQ9awvZDPy3o8iS3gw202JHD+bqIdggi
 UC14YfN4ZrjI7wuEC4DsSOrSczpv/7Y3Wf4HmgUgvtwNLvJKceDaTs8OI5dH73FH9cQD
 LY6TE4NtmLMKmcOTYdiuV4C8EDCAetO1QZCN9xqdK/xdCRgoQ6YoFfk4NseNKYsX3tLi
 Qc0/b7DsS7n+1jljKTJNoyZYK+mwbbZMW5CEsPWDVwNh7AN1d5Ycmr9yKEvU94TgPNyk
 JdQSXkO376pFgoEgPwv5M9iT0TLyDJytBSp3tnVR7+XNKX8CyRS3SRRnWZJuLkvJ1pKJ
 fUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aWkGNsj9H+PPXdmDM8jphreLemaKpKVhG6fjRtFnO8Q=;
 b=CRsp56QOkbYb8YkfZEl+cKRxoEUygFDDdP5/W1OzeW+ZkqRgI2p+ZH+Ww3dxvbJ1Un
 UuJUHWO78dO6dqaK8S8k5rmuTmGusSVoTZc5UlnZQEBd7ncHQ01Fp3wl8G7SZ0ZA/xrc
 ciRDM032CeXiUJGxNqkd45bYv8MfsEHbKniS9tL1H8sl1L3QZDF26AbH2oReekDbSQlt
 bJ/BGelhjgmiXvjOfeNHNuhSMdfDJUsw+UL5X0B+XJZlGNCxLFAnTIsCTd2NTqdaGFkj
 EhUAZ1w7OlXA7o7oFz41rH1aYzq7jW7w31xL4Qnyim8M0cwo+Ozwuq11dggMmoact2rT
 CNaA==
X-Gm-Message-State: AJcUukeil4TblC9rGWF+u83ADwWUi1IpKKZgn9Hz7u+D0VJHlXUo+5Mm
 EGf68TWackcnuzoBLzlJptDqgAk3Tl9/YiEX3Po=
X-Google-Smtp-Source: ALg8bN4TGwzzV9+rDqN6jqokcuS2worneigqBlgltDsQYW2kgwnVOXojAkAzi6U2DdppgszxXxvosU25VS4BiX6F4FQ=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr7847121lfc.27.1548397514916; 
 Thu, 24 Jan 2019 22:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20190111150834.GA2744@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190111150834.GA2744@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 25 Jan 2019 11:55:03 +0530
Message-ID: <CAFqt6zYLDrC7CtLawWUAQPyB_M+5H8BikDR6LOm+v0qaq1GvZw@mail.gmail.com>
Subject: Re: [PATCH 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range_buggy
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, 
 Michal Hocko <mhocko@suse.com>, stefanr@s5r6.in-berlin.de, 
 Russell King - ARM Linux <linux@armlinux.org.uk>, robin.murphy@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_222517_602234_ABEF5437 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: Linux-MM <linux-mm@kvack.org>, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 8:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range_buggy to map range of kernel memory
> to user vma.
>
> This driver has ignored vm_pgoff and mapped the entire pages. We
> could later "fix" these drivers to behave according to the normal
> vm_pgoff offsetting simply by removing the _buggy suffix on the
> function name and if that causes regressions, it gives us an easy
> way to revert.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  drivers/firewire/core-iso.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> index 35e784c..99a6582 100644
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
>  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
>                           struct vm_area_struct *vma)
>  {
> -       unsigned long uaddr;
> -       int i, err;
> -
> -       uaddr = vma->vm_start;
> -       for (i = 0; i < buffer->page_count; i++) {
> -               err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> -               if (err)
> -                       return err;
> -
> -               uaddr += PAGE_SIZE;
> -       }
> -
> -       return 0;
> +       return vm_insert_range_buggy(vma, buffer->pages,
> +                                       buffer->page_count);
>  }
>
>  void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
> --
> 1.9.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
