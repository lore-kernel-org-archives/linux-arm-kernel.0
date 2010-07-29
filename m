From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jul 2010 10:26:55 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
References: <ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
	<20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <201007291026.55928.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 July 2010 05:35:48 FUJITA Tomonori wrote:
> > 
> > From what I have been able to tell, the IOMMU interface was written by
> > AMD/Intel to allow the kvm code to work with a common IOMMU interface. To
> 
> Don't confuse the IOMMU interface with the DMA API that Arnd
> mentioned.
> 
> They are not related at all.

Exactly, thanks for the clarification. I also didn't realize that there
is now an include/linux/iommu.h file that only describes the PCI SR-IOV
interfaces, unlike the generic IOMMU support that we have in your
include/linux/dma-mapping.h file.

Maybe we should rename linux/iommu.h to something more specific so we
can reduce this confusion in the future.

	Arnd
