Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE71FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:50:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFE72082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J1YDOEAZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n4iKpYFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFE72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TPK2ibYwLat2xMT0xoT15IF6yBiz6M4KfsursAHguyM=; b=J1YDOEAZJ1oJWa
	grlatURbDdlG+u1pEHNJv1dk3Jhdoc8k5ymAUZJIFzlDxgGr5CGDUr35+IsLeyCXf4AoGYv9Apfk4
	i/zxneBaXsp1lfGRu5dXoXDtvHKzeXZn6z+b1RWYqeQnvgIGFPTeBqhVLAI515BRsDN4UYbF+2Wwv
	emApaVGa0skg0Qv3Dml2Pxy6T5twtKYBQpor6iNOgFuWGCLU0BG21u6ccbLMsxINMPdzuzRShDAM5
	4tsb7gjA6Vb9Emu/LhQ7pRkGuQsgh2x+cGBjXYoTAB8A5OP1aT6v959t5+seO3uf0eiOO8KHkDeuK
	3B/AysBmMSufSVgL/WSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkgC-00005v-PG; Thu, 06 Dec 2018 03:50:24 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkg6-0008EQ-9g
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:50:22 +0000
Received: by mail-pg1-x542.google.com with SMTP id d72so9997865pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 19:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3TanGnesUsXNVn4844W69r0sdlZW07QzX84i1mc2ruc=;
 b=n4iKpYFuCsH1xA1otB/jI2EqcwcOQmpEOIdGbvJiQNedw8Kc9IEcsfxnxcRMZH2Z8L
 fK1ox8RGreiHOpL4xMiS5n4U84c+hytx8pYjjBlfPwJuCSYpHtvMqw7ntPgmaR8IrknZ
 PQpQtULyiFL3jMILWjQd+VohMxSBVy8rBHtkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3TanGnesUsXNVn4844W69r0sdlZW07QzX84i1mc2ruc=;
 b=SfBvQDR5puF9QDfyCwC9Emx9BT8GxDD4+GAdVDi0ZMamxyVFUBaNPWuG356prg5TEi
 d6bdAxlSroVKklERzI84GsLIRVkR995NSQJ3btCYlHvwNsEnkwSxhpOXZzz67Wt6agiv
 UnReIlgewMbOg5A6BFt5Gk/paGhTYfbfmawHAHjXHGn+MrdgFxeiZHc9GfkyNDm26rd4
 GC6HT1ibdNFoTNQJ2G96+v3qzsc/HsQgZIcM/fpbRXnvj3W8ixjQ/g5fAR1O4xVJJNXD
 txUCaU6tpKcaukscaIi6K5JwZFXHM9eLe9jPrx/rcDI3biCwV0zQ48UQp5IyPZHxPb38
 TZlg==
X-Gm-Message-State: AA+aEWbsJELMdG75IE3tsZTLwol4lOjHnXOCufmGJYcvkOUt05+weyDR
 5DmiJqmuoNSBJ/hze7G5K9H+oZW7y+IaMNgLfQ4s/w==
X-Google-Smtp-Source: AFSGD/Xj8k7u3b/6AxdfCY5AJwNH1NSuwNCeYLgW4Q2aH75/tTCsehuPK3DKJ3REX3y2ESYdqxyf5wN20Nv1UgxPquA=
X-Received: by 2002:a63:fb46:: with SMTP id w6mr22933804pgj.321.1544068206996; 
 Wed, 05 Dec 2018 19:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org>
 <5eddd264-5527-a98e-fc8b-31ea89f474db@suse.cz>
In-Reply-To: <5eddd264-5527-a98e-fc8b-31ea89f474db@suse.cz>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 6 Dec 2018 11:49:55 +0800
Message-ID: <CANMq1KAL7TcVa4xF8=NdK2cs0VakEq5i6MyCvfmYTGCmJ78-ag@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
To: Vlastimil Babka <vbabka@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_195018_343411_2D7E9774 
X-CRM114-Status: GOOD (  29.88  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 10:02 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/5/18 6:48 AM, Nicolas Boichat wrote:
> > In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
> > data structures smaller than a page with GFP_DMA32 flag.
> >
> > This change makes it possible to create a custom cache in DMA32 zone
> > using kmem_cache_create, then allocate memory using kmem_cache_alloc.
> >
> > We do not create a DMA32 kmalloc cache array, as there are currently
> > no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
> > ensures that such calls still fail (as they do before this change).
> >
> > Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
>
> Same as my comment for 1/3.

I'll drop.

> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> In general,
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Some comments below:
>
> > ---
> >
> > Changes since v2:
> >  - Clarified commit message
> >  - Add entry in sysfs-kernel-slab to document the new sysfs file
> >
> > (v3 used the page_frag approach)
> >
> > Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
> >  include/linux/slab.h                        |  2 ++
> >  mm/internal.h                               |  8 ++++++--
> >  mm/slab.c                                   |  4 +++-
> >  mm/slab.h                                   |  3 ++-
> >  mm/slab_common.c                            |  2 +-
> >  mm/slub.c                                   | 18 +++++++++++++++++-
> >  7 files changed, 40 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
> > index 29601d93a1c2ea..d742c6cfdffbe9 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-slab
> > +++ b/Documentation/ABI/testing/sysfs-kernel-slab
> > @@ -106,6 +106,15 @@ Description:
> >               are from ZONE_DMA.
> >               Available when CONFIG_ZONE_DMA is enabled.
> >
> > +What:                /sys/kernel/slab/cache/cache_dma32
> > +Date:                December 2018
> > +KernelVersion:       4.21
> > +Contact:     Nicolas Boichat <drinkcat@chromium.org>
> > +Description:
> > +             The cache_dma32 file is read-only and specifies whether objects
> > +             are from ZONE_DMA32.
> > +             Available when CONFIG_ZONE_DMA32 is enabled.
>
> I don't have a strong opinion. It's a new file, yeah, but consistent
> with already existing ones. I'd leave the decision with SL*B maintainers.
>
> >  What:                /sys/kernel/slab/cache/cpu_slabs
> >  Date:                May 2007
> >  KernelVersion:       2.6.22
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 11b45f7ae4057c..9449b19c5f107a 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -32,6 +32,8 @@
> >  #define SLAB_HWCACHE_ALIGN   ((slab_flags_t __force)0x00002000U)
> >  /* Use GFP_DMA memory */
> >  #define SLAB_CACHE_DMA               ((slab_flags_t __force)0x00004000U)
> > +/* Use GFP_DMA32 memory */
> > +#define SLAB_CACHE_DMA32     ((slab_flags_t __force)0x00008000U)
> >  /* DEBUG: Store the last owner for bug hunting */
> >  #define SLAB_STORE_USER              ((slab_flags_t __force)0x00010000U)
> >  /* Panic if kmem_cache_create() fails */
> > diff --git a/mm/internal.h b/mm/internal.h
> > index a2ee82a0cd44ae..fd244ad716eaf8 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/mm.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/slab.h>
> >  #include <linux/tracepoint-defs.h>
> >
> >  /*
> > @@ -34,9 +35,12 @@
> >  #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
> >
> >  /* Check for flags that must not be used with a slab allocator */
> > -static inline gfp_t check_slab_flags(gfp_t flags)
> > +static inline gfp_t check_slab_flags(gfp_t flags, slab_flags_t slab_flags)
> >  {
> > -     gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
> > +     gfp_t bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
> > +
> > +     if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
> > +             bug_mask |= __GFP_DMA32;
>
> I'll point out that this is not even strictly needed AFAICS, as only
> flags passed to kmem_cache_alloc() are checked - the cache->allocflags
> derived from SLAB_CACHE_DMA32 are appended only after check_slab_flags()
> (in both SLAB and SLUB AFAICS). And for a cache created with
> SLAB_CACHE_DMA32, the caller of kmem_cache_alloc() doesn't need to also
> include __GFP_DMA32, the allocation will be from ZONE_DMA32 regardless.

Yes, you're right. I also looked at existing users of SLAB_CACHE_DMA,
and there is one case in drivers/scsi/scsi_lib.c where GFP_DMA is not
be passed (all the other users pass it).

I can drop GFP_DMA32 from my call in io-pgtable-arm-v7s.c.

> So it would be fine even unchanged. The check would anyway need some
> more love to catch the same with __GFP_DMA to be consistent and cover
> all corner cases.

Yes, the test is not complete. If we really wanted this to be
accurate, we'd need to check that GFP_* exactly matches SLAB_CACHE_*.

The only problem with dropping this is test that we should restore
GFP_DMA32 warning/errors somewhere else (as Christopher pointed out
here: https://lkml.org/lkml/2018/11/22/430), especially for kmalloc
case.

Maybe this can be done in kmalloc_slab.

> >
> >       if (unlikely(flags & bug_mask)) {
> >               gfp_t invalid_mask = flags & bug_mask;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
