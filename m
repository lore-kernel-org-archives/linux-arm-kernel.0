Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE0DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:58:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731F3217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JVjPeGLL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDjcJXXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731F3217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wxOKgQG1urVyETdA2sTohTa/gZBU4LA1y+JLUF2fH+w=; b=JVjPeGLLTg0CSH
	o3oEc/gt4Asl/9cWumhlBmsQyINEJEutcLqmeL1XbnrBYWqw2p8JZGImSZ0Csu1ZQ2JU6P3w24p/M
	rxPca6SBTA4SOe09ldIIesgu+yxIpwfH02QAJM7HTnVOh1VXmxdnJnF8BI6CZNgIZkdiDlE93/Y9t
	BUNIhObrW+qPvYy456zVeZdbhrdOBJ49So1lBdyzAHVo66le0CK/g+LCEL4OMg579JCreSrGeKcWb
	SCV/fjVS5c5O8kBROlTzw7ZSo12+jYCKJP8jlBM5CEuOsNVHFzyfrQT0QVP85n2+zNrbt3etCxnn1
	8mK3i697PfpqKUtBuCsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZEwy-0003Ws-Qo; Tue, 18 Dec 2018 12:58:16 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEwv-0003Vg-4S
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 12:58:14 +0000
Received: by mail-lj1-x243.google.com with SMTP id t18-v6so2105527ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LJEXeZy7r0kYuKM3hPFGswkGYVdPGlEwNSsUSbfadm8=;
 b=cDjcJXXxCqen79XtD8Eix24NpVMSUzZxn384UkAKmRCmq1v6wldgZEpj7uppmDQfUk
 lprFRzF1bSYLx3s4wPPJWpkO5Ag90kGJ8kxxvPx3eiqZXY+msiVZUCygUQC2uYwWlUVt
 bRJxDBlu5z6K0N0KojeXDy+FnEhAVf874SD83FzfFuWXJk+95BIltIf36IGx9zCd7S4Y
 NRjZcdEf4wH5kmk+Sdy70AzQLXJeZAIEO7P+sMRSqFlrDmEH+hTDHaCq7ZZspYQIJ+Vb
 lajs0tnqnckYIGF6dqp1qoge1YmIx+qnkzngzhe6el+i2mPPuXHKw4qiBdzNiTbwoY3v
 2URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LJEXeZy7r0kYuKM3hPFGswkGYVdPGlEwNSsUSbfadm8=;
 b=Zbu64GC6uY2tPAIqXTFTZMHh4lM+pMbNk3R1r1XOLUweHWE71rQWo2xQuOB73/WQXM
 AfdIpTwoMBBF8xhCc+jaCJXHLwIzqyck7I8yP1RxU3f+jRDVrksvTl+v/vTuayD5P0vz
 pSNjwVAKHios+/JBYhtrdm/jcaAUXvpmjcmn6l7pTvGMe/5pgE1gYDqGJS37nyrqwT1e
 Ob8NdiAq+eO7wn9WvQDoLgFfIjnC438Lylf0X/AKuHmpyD6GRq/OwxUJzCk05DcKN+w9
 CA/M7szJHOO//F4ZVzMwSC4Kmt2523GbVp2wOBEEBtncZv/supoKMdPua0lguyRDYnm0
 OYjw==
X-Gm-Message-State: AA+aEWbWDAYouRTfn//AWJS2BzKPgzSkKAU/FmsmbavkWbGDjkW75bvZ
 rE9BQ5gpz2G7Ges+2bCVx9VAWHLDQe0mcMR4Qv4=
X-Google-Smtp-Source: AFSGD/X1xQ2Y9yxGJNmnMra79GQM3gQrWIMtM2z1d/6UhNzHyUugtcxF1fs5kkuErNtpFv8H03bwisOZxtLr8o/ws2A=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr921004lji.93.1545137879090; 
 Tue, 18 Dec 2018 04:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20181217202209.GA8859@jordon-HP-15-Notebook-PC>
 <20181218093754.GI26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218093754.GI26090@n2100.armlinux.org.uk>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 18 Dec 2018 18:27:45 +0530
Message-ID: <CAFqt6zbQkFbX57D2kJqZa_gMH7tGzY6FGUJE7Y14kmiiHEv1AA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_045813_176943_B486E407 
X-CRM114-Status: GOOD (  23.75  )
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
Cc: Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 treding@nvidia.com, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 3:08 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 01:52:09AM +0530, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  arch/arm/mm/dma-mapping.c | 21 +++++++--------------
> >  1 file changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 661fe48..7cbcde5 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
> >                   void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >                   unsigned long attrs)
> >  {
> > -     unsigned long uaddr = vma->vm_start;
> > -     unsigned long usize = vma->vm_end - vma->vm_start;
> > +     unsigned long page_count = vma_pages(vma);
> >       struct page **pages = __iommu_get_pages(cpu_addr, attrs);
> >       unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >       unsigned long off = vma->vm_pgoff;
> > +     int err;
> >
> >       if (!pages)
> >               return -ENXIO;
> >
> > -     if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> > +     if (off >= nr_pages)
> >               return -ENXIO;
>
> Are you sure you can make this change?
>
> You are restricting the offset to be within 0..nr_pages which ensures
> that the initial struct page that is passed to vm_insert_range() is
> valid, but I think the removal of the following check is unsafe.
>
> Your new vm_insert_range() function only checks page_count <=
> vma_pages(vma), which it will be since it _is_ vma_pages(vma).  With
> the removal of the second condition, there will be nothing checking
> that (eg) off may be nr_pages - 1, and page_count=50, meaning that
> vm_insert_range() will walk off the end of the page array.
>
> Please take another look at this.

This check shouldn't be removed.
>
> What about the other callsites of your new function - do they have
> the same issue?

I think other callsites don't have the same issue.

>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
