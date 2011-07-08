From: sundaram@ti.com (Raju, Sundaram)
Date: Fri, 8 Jul 2011 13:52:17 +0530
Subject: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design plan
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am planning to move TI SDMA driver in OMAP tree
into the dmaengine framework.

The first immediate issue of concern I noticed is the
huge number of client drivers that use the existing SDMA driver.
More than 15 client drivers are using the current SDMA driver.

Moving the SDMA driver along with all of these client drivers at a
single stretch seems a humungous task. 
I noticed a model in the existing DMA drivers in dmaengine
framework that will over come this issue. 

I would like to follow the Freescale i.MX DMA driver model,
where imx-dma.c in drivers/dma which implements all the
dmaengine hooks, internally uses the APIs in dma-v1.c file in 
arch/arm/mach-imx. All APIs in dma-v1.c are also exported
out for direct use by clients.

Advantages of this model:
1. No compilation breaks for any of the existing client drivers.
2. Client drivers can be moved one by one to the new SDMA driver 
after complete testing on all OMAP boards.

We can mark the old SDMA driver APIs as deprecated and insist on
all client drivers to be moved to the new SDMA driver in the
dmaengine framework soon.

I have made the preliminary changes in code for this design and
I am in the phase of testing a few client drivers. If this is a good way
to proceed then I will send out my patches with the client drivers I
have changed for review once I am done with the testing.

Let me know your thoughts.

Regards,
Sundaram
