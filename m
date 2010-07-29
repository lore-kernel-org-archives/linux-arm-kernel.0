From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 29 Jul 2010 12:35:48 +0900
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
References: <ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<201007281950.20847.arnd@arndb.de>
	<bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
Message-ID: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jul 2010 17:58:50 -0700 (PDT)
stepanm at codeaurora.org wrote:

> >> These are just SMMU APIs, and the DMA-mapping API is one layer above
> >> this.
> >>
> >> We have our own SMMU API for the MSM SoCs because we have muliple
> >> IOMMUs,
> >> each one having multiple contexts, or even having multiple instances of
> >> the same context. Our usage model is also quite a bit different from how
> >> the DMA APIs are set up. I believe only two IOMMU drivers actually make
> >> use of the DMA API (Intel and AMD) and the other ones (OMAP and other
> >> SoCs) have their own APIs for their specific use cases.
> >
> > The DMA API is extremely flexible, it works just fine with all the
> > IOMMUs that I've seen so far. Please take a look at
> > include/asm-generic/dma-mapping-common.h and its users to see how
> > to use multiple IOMMUs depending on the device.
> >
> > If the OMAP developers got this wrong, that's not your problem :-)
> >
> > 	Arnd
> 
> Hi Arnd,
> 
> From what I have been able to tell, the IOMMU interface was written by
> AMD/Intel to allow the kvm code to work with a common IOMMU interface. To

Don't confuse the IOMMU interface with the DMA API that Arnd
mentioned.

They are not related at all.

The DMA API is defined in Documentation/DMA-API.txt.

Arnd told you that include/asm-generic/dma-mapping-common.h is the
library to support the DMA API with multiple IOMMUs. Lots of
architectures (x86, powerpc, sh, alpha, ia64, microblaze, sparc)
use it.
