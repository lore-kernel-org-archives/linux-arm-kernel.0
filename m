From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 Oct 2014 16:29:04 +0200
Subject: Unconditional registering EMDA platform devices
Message-ID: <20141024142904.GC3142@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt

I've had a report of a Debian kernel running on a Marvell XP system
giving warnings:

[    0.114771] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dummy slot
[    0.114794] edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

These seem to be coming from drivers/dma/emda.c

That driver has a subsys_initcall(edma_init);

and the edma_init function is unconditionally registering a driver and
a platform device. For a multiarch kernel, this is not a good idea.

Please could you make this conditionally. Maybe look into the DT and
see if the DMA is needed on the platform?

Thanks
	Andrew
