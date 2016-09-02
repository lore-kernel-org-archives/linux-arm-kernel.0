From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 15:10:34 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <956cf653-973a-3bfd-9aaa-bdc922995ea6@arm.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87eg528te7.fsf@linux.intel.com>
 <956cf653-973a-3bfd-9aaa-bdc922995ea6@arm.com>
Message-ID: <5224196.iEv3ICfjjt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 2, 2016 12:55:33 PM CEST Robin Murphy wrote:
> 
> Huh? There's only no DMA description in DT if the device can be assumed
> to be happy with the defaults. Anything else should be using
> "dma-ranges", "dma-coherent", etc. to describe non-default integration
> aspects. For devices with an inherent fixed addressing capability !=32
> bits, then it's down to the driver to call dma_set_mask() appropriately
> to override the default 32-bit mask (which is not unique to OF-probed
> devices either).

The iommu configuration would be the main other one worth mentioning.

Note that there is a known bug with dma_set_mask(), which always succeeds
at the moment, even if the dma-ranges limit the possible addresses
in a way that should fail.

	Arnd
