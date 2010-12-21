From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Dec 2010 12:53:17 +0100
Subject: [PATCH 1/2] ARM: convert dma-mapping to asm-generic API
In-Reply-To: <20101221105946.GP28157@n2100.arm.linux.org.uk>
References: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
	<201012211154.08821.arnd@arndb.de>
	<20101221105946.GP28157@n2100.arm.linux.org.uk>
Message-ID: <201012211253.17914.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 December 2010 11:59:46 Russell King - ARM Linux wrote:
> From what I understand on OMAP, they need to control the device address,
> physical address and (sometimes) CPU virtual address that an IOMMU
> mapping is created for.  If they did add support for their IOMMUs to
> the DMA API, the DMA API will be buried beneath their IOMMU layer.
> 
> The OMAP devices with IOMMUs are hardly generic drivers in any case -
> they tend to be there for their on-board DSP stuff.

What you describe is certainly true for the DSP interfaces, since they
share data structures in memory between the ARM and DSP cores.

My understanding of OMAP (probably more limited than yours) is that they
have lots of those IOMMUs all over the place though, so it would just
be a matter of time before someone needs them for something else.

The obvious use case for an IOMMU is to extend the addressable memory
a device gets, which will come up when someone combines a Cortex-A15
core with more than 4GB of RAM and devices that only have a 32 bit
address bus.

	Arnd
