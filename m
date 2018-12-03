Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29E5C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:22:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B958320848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o5PC6GNO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhtBZibI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B958320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3MAuvA0304bgEmuWy6QexVBdiaBAJ19WS08CyuQk4oI=; b=o5PC6GNOlIPy6P
	eSdn0uCx8jLK5XpdK4pVLx6X1I5ZEXh27rhXZZ/X4ylCp71HMnaWRhFemBidEY0cdsUYvydYKp9lZ
	+Us0aMiDkFetMfEx8u0p5011BGmUa5ccjoIOsUSpQjg6Vhr0UfffxIhX3L0hvVgxxmJVwwKEJuB72
	1IY/BP2O3jYgLUE6jxA/nU5aatpEnK12Rw+dpV0ouSmMpq2EOglghYMzBLTbT8teuSQUTwfBoC+W5
	8993EQAmWwyk6gLQ4vjWIsx0VwKmcwcr2gl4Lx5e5dDezXs9HTutSTFXQklkIRFS6Wk2Kajwaf8Yj
	26EOLV2/ft/4Jz5juogg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTfkK-0007Ek-Kc; Mon, 03 Dec 2018 04:22:12 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTfkH-0007Dm-7G; Mon, 03 Dec 2018 04:22:10 +0000
Received: by mail-lj1-x243.google.com with SMTP id v1-v6so10048113ljd.0;
 Sun, 02 Dec 2018 20:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SYCAqsoUZtLwLDlDfp6OtymT17dsOHDXcRiDcCLSAAI=;
 b=nhtBZibIwnBkPDHJCbP4PMmNHMC+hiwcwr8/1k8ga5Sa94daTE5kR2ylsNtJ+WtuWX
 vi8JsMjhfolq2sXSmYCU4pYFsgI7iElOBqAPbJZEu5BZThXXOWrM6uSz8ybFxIjUXrQO
 qfKX9UjocO3UbX66fUOUff0DRTmVTBfapCxbvoLq1kB6/jVnMQ/bgXyMgoE+TSOjkSwA
 StdMUVUi3E8wkOM9ibp9H4LqFJqe9Sa6/SeON6fsguiNgph3EZevdAYdC0Di6jhurgiJ
 ZEI1SQdsjs+0WCFseHxPJ+rzczhClEwUUA3de/d0wax+aruFf9NX5IqUtZkpvZAlrGsc
 Eodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SYCAqsoUZtLwLDlDfp6OtymT17dsOHDXcRiDcCLSAAI=;
 b=QAtGE5N0FPsMfIAZvoGdJMayPRKNai+sZXak9k6L2+jQzili+3Ypd0RVVcx0L53qXI
 ZFPsJx2E9sAuPRNvO2+0xPnvLHfJ8010mDQ4dbisjvGzFN5fjRvyBUaTZQxXh2l1NHuy
 t9BbPPRnfbeLCTGmkT5Ig8cbN5n5NS0cXmub4lPej7sq5NC9ySskfEUoPG4uuBJj1aPA
 24443vimrylUDY+ibsl71dlr9i3VfT2EACbsVYC5FFaER4XcF/pi1j1aYUi7ZdPfVMSp
 /yv4f6XB1stJv01dF+xrErQ2evoYiqQcGI5G923EWqzYzyZhCQRupHiI0HGbG6m6vSpR
 ZJPA==
X-Gm-Message-State: AA+aEWY2bnFWNNQNi8FsaSK0osXcSndSfJeQPVpXf+JNKClpDpbsXkHy
 LSHNgxjuTgApe+jdSSipf7bgTZbTMc7RMLlxrRk=
X-Google-Smtp-Source: AFSGD/ULEaU52DpGnoEB0+B391rVIknIq95m9aFt1PWmOEugtipxjN1gDll5xHanHFuNsFuqFVfAnPwwh/hYD9vnflk=
X-Received: by 2002:a2e:630a:: with SMTP id
 x10-v6mr8707628ljb.11.1543810916221; 
 Sun, 02 Dec 2018 20:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20181202061944.GA3094@jordon-HP-15-Notebook-PC>
 <20181202111313.GC6959@rapoport-lnx>
In-Reply-To: <20181202111313.GC6959@rapoport-lnx>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 3 Dec 2018 09:51:45 +0530
Message-ID: <CAFqt6zbvyaPF3tUA1-=RsfSM14p7Rx5NgQqAeW5-JUfd+NrJ2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mm: Introduce new vm_insert_range API
To: rppt@linux.ibm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_202209_272242_F79BC98C 
X-CRM114-Status: GOOD (  28.86  )
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

Hi Mike,

On Sun, Dec 2, 2018 at 4:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Sun, Dec 02, 2018 at 11:49:44AM +0530, Souptick Joarder wrote:
> > Previouly drivers have their own way of mapping range of
> > kernel pages/memory into user vma and this was done by
> > invoking vm_insert_page() within a loop.
> >
> > As this pattern is common across different drivers, it can
> > be generalized by creating a new function and use it across
> > the drivers.
> >
> > vm_insert_range is the new API which will be used to map a
> > range of kernel memory/pages to user vma.
> >
> > This API is tested by Heiko for Rockchip drm driver, on rk3188,
> > rk3288, rk3328 and rk3399 with graphics.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  include/linux/mm_types.h |  3 +++
> >  mm/memory.c              | 38 ++++++++++++++++++++++++++++++++++++++
> >  mm/nommu.c               |  7 +++++++
> >  3 files changed, 48 insertions(+)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5ed8f62..15ae24f 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -523,6 +523,9 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
> >  extern void tlb_finish_mmu(struct mmu_gather *tlb,
> >                               unsigned long start, unsigned long end);
> >
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +                     struct page **pages, unsigned long page_count);
> > +
>
> This seem to belong to include/linux/mm.h, near vm_insert_page()

Ok, I will change it. Apart from this change does it looks good ?

>
> >  static inline void init_tlb_flush_pending(struct mm_struct *mm)
> >  {
> >       atomic_set(&mm->tlb_flush_pending, 0);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 15c417e..84ea46c 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1478,6 +1478,44 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >
> >  /**
> > + * vm_insert_range - insert range of kernel pages into user vma
> > + * @vma: user vma to map to
> > + * @addr: target user address of this page
> > + * @pages: pointer to array of source kernel pages
> > + * @page_count: number of pages need to insert into user vma
> > + *
> > + * This allows drivers to insert range of kernel pages they've allocated
> > + * into a user vma. This is a generic function which drivers can use
> > + * rather than using their own way of mapping range of kernel pages into
> > + * user vma.
> > + *
> > + * If we fail to insert any page into the vma, the function will return
> > + * immediately leaving any previously-inserted pages present.  Callers
> > + * from the mmap handler may immediately return the error as their caller
> > + * will destroy the vma, removing any successfully-inserted pages. Other
> > + * callers should make their own arrangements for calling unmap_region().
> > + *
> > + * Context: Process context. Called by mmap handlers.
> > + * Return: 0 on success and error code otherwise
> > + */
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +                     struct page **pages, unsigned long page_count)
> > +{
> > +     unsigned long uaddr = addr;
> > +     int ret = 0, i;
> > +
> > +     for (i = 0; i < page_count; i++) {
> > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > +             if (ret < 0)
> > +                     return ret;
> > +             uaddr += PAGE_SIZE;
> > +     }
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(vm_insert_range);
> > +
> > +/**
> >   * vm_insert_page - insert single page into user vma
> >   * @vma: user vma to map to
> >   * @addr: target user address of this page
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 749276b..d6ef5c7 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL(vm_insert_page);
> >
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +                     struct page **pages, unsigned long page_count)
> > +{
> > +     return -EINVAL;
> > +}
> > +EXPORT_SYMBOL(vm_insert_range);
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
