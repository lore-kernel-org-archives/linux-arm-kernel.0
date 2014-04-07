From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 07 Apr 2014 15:12:43 +0200
Subject: Porting plat-pxa to the MMP PDMA driver
Message-ID: <3296408.nMPs78xkYH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The MMP DMA (drivers/dma/mmap_pdma.c) driver supports the DMA engine found in 
PXA chips. However, PXA platforms still use a mix of custom platform code 
(arch/arm/plat-pxa/dma.c) and direct DMA controller access in various drivers 
(pata_pxa, spi-pxa2xx, pxa3xx_nand, pxaficp_ir, pxamci, smc91x, smc911x and 
pxa_camera).

I'd like to use the MMP PDMA driver through the DMA engine API in a new driver 
I'm writing instead of the legacy PXA DMA code. However, this requires porting 
the platform to the MMP PDMA driver first, which involves porting all the 
above drivers to the DMA engine API. The spi-pxa2xx driver has already been 
ported and currently supports both the legacy PXA DMA API and the DMA engine 
API. All the other drivers seem to require the legacy PXA DMA API.

I was wondering if any effort had been started in that direction. I could 
possibly help with the pxamci driver, but not with the other drivers as the 
corresponding peripherals are not used on my test platform (a custom PXA27x 
board).

-- 
Regards,

Laurent Pinchart
