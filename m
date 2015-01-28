From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Jan 2015 13:53:55 +0000
Subject: [RFC PATCH 3/5] iommu: implement common IOMMU ops for DMA mapping
In-Reply-To: <20150127123809.GJ30345@8bytes.org>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <09e5515a9afcb3235f4c425520cd18a6032d31b4.1421086706.git.robin.murphy@arm.com>
 <20150127002116.GI30345@8bytes.org> <54C7843B.3000605@arm.com>
 <20150127123809.GJ30345@8bytes.org>
Message-ID: <20150128135355.GO1569@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 12:38:09PM +0000, Joerg Roedel wrote:
> On Tue, Jan 27, 2015 at 12:27:39PM +0000, Robin Murphy wrote:
> > Laz^WPragmatism - I'm expecting quite a lot of changes to get this
> > looking good, so keeping the series as lean as possible to aid
> > reviewing/rebasing/etc. seemed sensible. In the same vein, since the
> > other architectures already have code that works, my priority is
> > getting something in place to fill the gap in arm64 (my current
> > remit is "get the SMMUs on Juno working"); it seemed logical to
> > minimise disruption and dependencies by aiming to get this merged
> > with the one user, then start porting the others (and making the
> > inevitable necessary tweaks) once it's in.
> > 
> > I'll adjust the commit message to make that clearer - on re-reading
> > it, it does come across as rather vague about that intent.
> 
> Yeah, probably we can add other architectures later (like x86). But can
> you at least merge it with the existing version of this for ARM32? That
> should be easier to achieve than extending it for x86 by now and we do
> not end up with two similar implementations.

+1 on that front. We've already had some breakage by using the arm_iommu_*
API for the automatic DMA mapping bits, so I'd love to have dma-mapping
use the same core code between arm and arm64 as soon as we can, leaving
the ARM-specific API for the (hopefully diminishing) set of explicit
callers.

Will
