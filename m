From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Fri, 25 Sep 2009 14:53:06 +0200
Subject: [at91sam9g45] DMA driver for AC97 and MCI
Message-ID: <4ABCBD32.7080408@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I try to get sound and SD card working on at91sam9g45-ekes development board using linux-next tree. As far as I understand AT_HDMAC is the appropriate DMA driver for ARCH_AT91SAM9G45. I resolved dependencies with this patch, so I could activate it for my platform.

--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -48,7 +48,7 @@ config DW_DMAC

 config AT_HDMAC
        tristate "Atmel AHB DMA support"
-       depends on ARCH_AT91SAM9RL
+       depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
        select DMA_ENGINE
        help
          Support the Atmel AHB DMA controller.  This can be integrated in

Should this driver be also used for sound driver and MCI? 

Best regards,
Yegor
