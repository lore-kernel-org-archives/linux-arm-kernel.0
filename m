From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu,  6 Aug 2015 19:22:38 -0700
Subject: [PATCH] ARM: brcmstb: select ARCH_DMA_ADDR_T_64BIT for LPAE
Message-ID: <1438914158-12439-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom STB (BRCMSTB) has some 64-bit capable DMA and therefore needs
dma_addr_t to be a 64-bit size.  One user is the Broadcom SATA3 AHCI
controller driver.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 0ac9e4b3..833b2d5 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -144,6 +144,7 @@ config ARCH_BRCMSTB
 	select BRCMSTB_GISB_ARB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
-- 
1.9.1
