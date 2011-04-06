From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 6 Apr 2011 21:24:31 +0400
Subject: [PATCH 1/3] DA8xx: kill duplicate #define DA8XX_GPIO_BASE
Message-ID: <201104062124.31206.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DA8XX_GPIO_BASE is #define'd in both <mach/da8xx.h> and devices-da8xx.c;
moreover, it's not even used in the latter file...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree plus the fix that I've posted
earlier today.

 arch/arm/mach-davinci/devices-da8xx.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-davinci/arch/arm/mach-davinci/devices-da8xx.c
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/devices-da8xx.c
+++ linux-davinci/arch/arm/mach-davinci/devices-da8xx.c
@@ -36,7 +36,6 @@
 #define DA8XX_EMAC_CPGMACSS_BASE	0x01e22000
 #define DA8XX_EMAC_CPGMAC_BASE		0x01e23000
 #define DA8XX_EMAC_MDIO_BASE		0x01e24000
-#define DA8XX_GPIO_BASE			0x01e26000
 #define DA8XX_I2C1_BASE			0x01e28000
 #define DA8XX_SPI0_BASE			0x01c41000
 #define DA830_SPI1_BASE			0x01e12000
