Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E3C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:13:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C650218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZD44wYZe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsGlgijO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C650218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EMPYxyfxeupvW39yqDfAl7jFNYUXVEpjaHohDsRFckU=; b=ZD44wYZe2lH0RQ
	wi3qUjTrwX5XtkREOSPmMdmZ+7sf7UbRTH3onR75OIEifcAwR8JV5z7AjRK0D+lWCSxYVt0UyDUR6
	7RW7ZAkvEsJ3QVV0eauxYuKBo9YEpnPr9nZSnEbKkwYsilh1hSGCwIlOcP0zWAF0OKI1WSZTYsvXS
	7F80P51x0UZqSOY2AtomrmV0YEcvFqF/2Rq1w1hZnHBqIu52uLQLRLzZjqu7fWsEn9lG/xsH65azP
	lsqSLT9DjjljOrP314t97BbdWg93Ry382eESqFtLUs1OLwcn6CymINVqkKolnO/yKtGY8Dtt/Ifoh
	37+oE5ownvgZ7EIjz5+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp9M6-00061q-G8; Thu, 31 Jan 2019 10:13:58 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9M2-000616-QA; Thu, 31 Jan 2019 10:13:56 +0000
Received: by mail-lj1-x244.google.com with SMTP id x85-v6so2190645ljb.2;
 Thu, 31 Jan 2019 02:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i7aqIU67iTXfnMOyJql1uNrnoPFgHw1gIYpbByUl8SQ=;
 b=WsGlgijO3cknHXg1mEI+dHF6KGXSU6wDgOORDOLKHOpHi0m1l1JKujU0tp7ZlYc9P/
 bRvhwLAUOzl9V9aJKStjWeHqNi4xsROdHbSBe53DVTdSScRktYADRRc0vzdv4cDiTm4F
 9T0KugzXwzP85vvF8hZbi+Se8r6pYBcDfIVI+SFvtze0wl2aemZC+nP2bxGrTNkR/7xE
 1Y+PLTRpZfThQ6XeAl/2KYZ5vQmW4Y2XZbdwT9uvbzK5lrEBldjdC5GRg3M2nLtBgyd3
 bhICRRdwsmbCEkyPJP7Tv3yA1gAf/1TfDAGqj8hQQhNaq8AJI6KmXOirb7XINlvrjq/3
 MF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i7aqIU67iTXfnMOyJql1uNrnoPFgHw1gIYpbByUl8SQ=;
 b=UVdXvJsK8DCJ6fGCthXx/hmiaw0Vk1xhZq2uqThZ6ocZv5gr+SOuK7r+MaS7GAy5gY
 vLbieR2CmQ2wcIfIxVMKq6mglVZasu5P5aM+j7hHma9dLa8Wa+ES57a5THwwe70pUPPS
 KXJlv5l7sWQId4FiQAqGcgF/Jqa8oXRuqt1keUwapAV9AGdZgfjBxh33WsbwdO/EDw0N
 pB2vKyqZZMWJ3Hs5c0kVUUyTS8pPPQ+vsnjl4JQh+vh4VyZC25h+SF0aBRhcbunkG/ux
 N1ZR8blHnVbsEEwRx9IoPeb0fuNRFOiofw0AUt8whouf206msoN1tthsQ7GynwcRea8k
 hfiQ==
X-Gm-Message-State: AJcUukdsTSkYIn9zGi7P8PhAJXuZdfPHRzgyIpVpR/nAorQ3364+cwWB
 gw9PFXz86s/vrC4BSHqXTdQg1Cdw82h8LZXMc6I=
X-Google-Smtp-Source: ALg8bN5d9Tpv6yTO6iC1E2jXBwzQgeTYpfILSW2IqBb3XFVwUI9hGn0qP+a8Il7n8MA2pe75YkgVoxkOXZD+HBbfEaQ=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr27364491ljj.9.1548929631905; 
 Thu, 31 Jan 2019 02:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <20190131083842.GE28876@rapoport-lnx>
In-Reply-To: <20190131083842.GE28876@rapoport-lnx>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 31 Jan 2019 15:43:39 +0530
Message-ID: <CAFqt6zbG089qCYBoZ8HCHPaRm+Yi=gHNboxy9y_qw9eVpSFjag@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
To: Mike Rapoport <rppt@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_021354_848774_3C4B1143 
X-CRM114-Status: GOOD (  30.91  )
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
Cc: Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
 Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, pawel@osciak.com,
 Rik van Riel <riel@surriel.com>, iommu@lists.linux-foundation.org,
 rppt@linux.vnet.ibm.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 mchehab@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
 Juergen Gross <jgross@suse.com>, hjc@rock-chips.com, xen-devel@lists.xen.org,
 Kyungmin Park <kyungmin.park@samsung.com>, stefanr@s5r6.in-berlin.de,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 2:09 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Jan 31, 2019 at 08:38:12AM +0530, Souptick Joarder wrote:
> > Previouly drivers have their own way of mapping range of
> > kernel pages/memory into user vma and this was done by
> > invoking vm_insert_page() within a loop.
> >
> > As this pattern is common across different drivers, it can
> > be generalized by creating new functions and use it across
> > the drivers.
> >
> > vm_insert_range() is the API which could be used to mapped
> > kernel memory/pages in drivers which has considered vm_pgoff
> >
> > vm_insert_range_buggy() is the API which could be used to map
> > range of kernel memory/pages in drivers which has not considered
> > vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> >
> > We _could_ then at a later "fix" these drivers which are using
> > vm_insert_range_buggy() to behave according to the normal vm_pgoff
> > offsetting simply by removing the _buggy suffix on the function
> > name and if that causes regressions, it gives us an easy way to revert.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Suggested-by: Russell King <linux@armlinux.org.uk>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  include/linux/mm.h |  4 +++
> >  mm/memory.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/nommu.c         | 14 ++++++++++
> >  3 files changed, 99 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 80bb640..25752b0 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2565,6 +2565,10 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
> >  int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
> >                       unsigned long pfn, unsigned long size, pgprot_t);
> >  int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
> > +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > +                             unsigned long num);
> > +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> > +                             unsigned long num);
> >  vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
> >                       unsigned long pfn);
> >  vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> > diff --git a/mm/memory.c b/mm/memory.c
> > index e11ca9d..0a4bf57 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1520,6 +1520,87 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL(vm_insert_page);
> >
> > +/**
> > + * __vm_insert_range - insert range of kernel pages into user vma
> > + * @vma: user vma to map to
> > + * @pages: pointer to array of source kernel pages
> > + * @num: number of pages in page array
> > + * @offset: user's requested vm_pgoff
> > + *
> > + * This allows drivers to insert range of kernel pages they've allocated
> > + * into a user vma.
> > + *
> > + * If we fail to insert any page into the vma, the function will return
> > + * immediately leaving any previously inserted pages present.  Callers
> > + * from the mmap handler may immediately return the error as their caller
> > + * will destroy the vma, removing any successfully inserted pages. Other
> > + * callers should make their own arrangements for calling unmap_region().
> > + *
> > + * Context: Process context.
> > + * Return: 0 on success and error code otherwise.
> > + */
> > +static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > +                             unsigned long num, unsigned long offset)
> > +{
> > +     unsigned long count = vma_pages(vma);
> > +     unsigned long uaddr = vma->vm_start;
> > +     int ret, i;
> > +
> > +     /* Fail if the user requested offset is beyond the end of the object */
> > +     if (offset > num)
> > +             return -ENXIO;
> > +
> > +     /* Fail if the user requested size exceeds available object size */
> > +     if (count > num - offset)
> > +             return -ENXIO;
> > +
> > +     for (i = 0; i < count; i++) {
> > +             ret = vm_insert_page(vma, uaddr, pages[offset + i]);
> > +             if (ret < 0)
> > +                     return ret;
> > +             uaddr += PAGE_SIZE;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * vm_insert_range - insert range of kernel pages starts with non zero offset
> > + * @vma: user vma to map to
> > + * @pages: pointer to array of source kernel pages
> > + * @num: number of pages in page array
> > + *
> > + * Maps an object consisting of `num' `pages', catering for the user's
> > + * requested vm_pgoff
> > + *
>
> The elaborate description you've added to __vm_insert_range() is better put
> here, as this is the "public" function.

Ok, will add it in v3. Which means __vm_insert_range() still needs a short
description ?
>
> > + * Context: Process context. Called by mmap handlers.
> > + * Return: 0 on success and error code otherwise.
> > + */
> > +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > +                             unsigned long num)
> > +{
> > +     return __vm_insert_range(vma, pages, num, vma->vm_pgoff);
> > +}
> > +EXPORT_SYMBOL(vm_insert_range);
> > +
> > +/**
> > + * vm_insert_range_buggy - insert range of kernel pages starts with zero offset
> > + * @vma: user vma to map to
> > + * @pages: pointer to array of source kernel pages
> > + * @num: number of pages in page array
> > + *
> > + * Maps a set of pages, always starting at page[0]
>
> Here I'd add something like:
>
> Similar to vm_insert_range(), except that it explicitly sets @vm_pgoff to
> 0. This function is intended for the drivers that did not consider
> @vm_pgoff.

Ok.

>
> > vm_insert_range_buggy() is the API which could be used to map
> > range of kernel memory/pages in drivers which has not considered
> > vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
>
> > + *
> > + * Context: Process context. Called by mmap handlers.
> > + * Return: 0 on success and error code otherwise.
> > + */
> > +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> > +                             unsigned long num)
> > +{
> > +     return __vm_insert_range(vma, pages, num, 0);
> > +}
> > +EXPORT_SYMBOL(vm_insert_range_buggy);
> > +
> >  static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
> >                       pfn_t pfn, pgprot_t prot, bool mkwrite)
> >  {
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 749276b..21d101e 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -473,6 +473,20 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL(vm_insert_page);
> >
> > +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> > +                     unsigned long num)
> > +{
> > +     return -EINVAL;
> > +}
> > +EXPORT_SYMBOL(vm_insert_range);
> > +
> > +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> > +                             unsigned long num)
> > +{
> > +     return -EINVAL;
> > +}
> > +EXPORT_SYMBOL(vm_insert_range_buggy);
> > +
> >  /*
> >   *  sys_brk() for the most part doesn't need the global kernel
> >   *  lock, except when an application is doing something nasty
> > --
> > 1.9.1
> >
>
> --
> Sincerely yours,
> Mike.
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
