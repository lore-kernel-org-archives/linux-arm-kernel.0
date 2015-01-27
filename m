From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 27 Jan 2015 13:38:09 +0100
Subject: [RFC PATCH 3/5] iommu: implement common IOMMU ops for DMA mapping
In-Reply-To: <54C7843B.3000605@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <09e5515a9afcb3235f4c425520cd18a6032d31b4.1421086706.git.robin.murphy@arm.com>
 <20150127002116.GI30345@8bytes.org> <54C7843B.3000605@arm.com>
Message-ID: <20150127123809.GJ30345@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 12:27:39PM +0000, Robin Murphy wrote:
> Laz^WPragmatism - I'm expecting quite a lot of changes to get this
> looking good, so keeping the series as lean as possible to aid
> reviewing/rebasing/etc. seemed sensible. In the same vein, since the
> other architectures already have code that works, my priority is
> getting something in place to fill the gap in arm64 (my current
> remit is "get the SMMUs on Juno working"); it seemed logical to
> minimise disruption and dependencies by aiming to get this merged
> with the one user, then start porting the others (and making the
> inevitable necessary tweaks) once it's in.
> 
> I'll adjust the commit message to make that clearer - on re-reading
> it, it does come across as rather vague about that intent.

Yeah, probably we can add other architectures later (like x86). But can
you at least merge it with the existing version of this for ARM32? That
should be easier to achieve than extending it for x86 by now and we do
not end up with two similar implementations.

> >>  lib/dma-iommu.c           | 455 ++++++++++++++++++++++++++++++++++++++++++++++
> >
> >I'd like this to live in drivers/iommu, as most other dma-api
> >implementations for iommu-drivers also live there.
> >
> 
> That's reasonable - I was trying to model this on SWIOTLB, so it
> ended up in the same place. Mind you, I suppose there's a fair
> argument for moving SWIOTLB over to drivers/iommu too.

SWIOTLB is used outside of iommu code too, like in Xen for example. So I
think it could stay in lib/. But a dma-ops implemention using iommu-api
only used iommu-code and should be in drivers/iommu.

> Indeed, that comment is pretty ancient and the 'proper' one was
> already half-done when I posted this; It'll be in v2.

Thanks.

Regards,

	Joerg
