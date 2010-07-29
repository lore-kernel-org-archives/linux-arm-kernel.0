From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Thu, 29 Jul 2010 10:40:19 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <201007291026.55928.arnd@arndb.de>
References: <ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<bad58db98c165a61860827d4e720acf8.squirrel@www.codeaurora.org>
	<20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de>
Message-ID: <20100729084018.GM26098@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 04:26:55AM -0400, Arnd Bergmann wrote:
> On Thursday 29 July 2010 05:35:48 FUJITA Tomonori wrote:
> > > 
> > > From what I have been able to tell, the IOMMU interface was written by
> > > AMD/Intel to allow the kvm code to work with a common IOMMU interface. To
> > 
> > Don't confuse the IOMMU interface with the DMA API that Arnd
> > mentioned.
> > 
> > They are not related at all.

Thats not 100% true. They are not strictly related, but they are related
as they may use the same backend kernel drivers to provide their
functionality. Both APIs exist for different purposes, of course.

> Exactly, thanks for the clarification. I also didn't realize that there
> is now an include/linux/iommu.h file that only describes the PCI SR-IOV
> interfaces, unlike the generic IOMMU support that we have in your
> include/linux/dma-mapping.h file.

The IOMMU-API is not about SR-IOV. It is about the capabilities of
modern IOMMU hardware that we can not provide to the kernel with the
DMA-API such as the ability to choose ourself at which io-virtual
address a given cpu physical address should be mapped.
Also I wouldn't call the DMA-API an IOMMU interface. The API does not
depend on an IOMMU which is an important difference to the IOMMU-API.
The IOMMU-API is probably not generic enough to handle all kinds of
IOMMUs but its closer to a generic IOMMU-API than the DMA-API.

		Joerg

-- 
Joerg Roedel - AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
