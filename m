From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Nov 2011 01:46:18 -0200
Subject: [PATCH] arm: device.h: Add dma_mask to pdev_archdata structure
Message-ID: <1321415178-12179-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build error when doing a 'make mx3_defconfig'

CC [M]  drivers/usb/host/fsl-mph-dr-of.o
drivers/usb/host/fsl-mph-dr-of.c: In function 'fsl_usb2_device_register':
drivers/usb/host/fsl-mph-dr-of.c:97: error: 'struct pdev_archdata' has no member named 'dma_mask'
make[3]: *** [drivers/usb/host/fsl-mph-dr-of.o] Error 1
make[2]: *** [drivers/usb/host] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/include/asm/device.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 7aa3680..6ec60f6 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -21,6 +21,7 @@ struct pdev_archdata {
 #ifdef CONFIG_ARCH_OMAP
 	struct omap_device *od;
 #endif
+	u64 dma_mask;
 };
 
 #endif
-- 
1.7.1
