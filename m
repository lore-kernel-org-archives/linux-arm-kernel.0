From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jul 2012 10:41:40 +0100
Subject: how to specify dma_mask and coherent_dma_mask in hwmod
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9AB214@DBDE01.ent.ti.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9AB214@DBDE01.ent.ti.com>
Message-ID: <20120704094140.GB16639@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 04:22:17PM +0000, N, Mugunthan V wrote:
> While converting platform device registry to Hwmod for CPSW Ethernet
> driver which is present in AM335X (OMAP2+), I am not finding a way
> to specify dma_mask and coherent_dma_mask.
> Is there a way to specify dma_mask and coherent_dma_mask in hwmod?

Just remember that we're moving stuff to DMA engine, and that means
the sDMA device has DMA masks, but none of the peripherals which make
use of sDMA should have DMA masks set.

The reason for this is because the device responsible for accessing
memory is sDMA, not the peripheral device, and therefore any memory
properties for DMA should come from the sDMA device, not the peripheral
device.
