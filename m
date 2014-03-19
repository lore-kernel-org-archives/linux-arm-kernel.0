From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:03 +0100
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ohci-da8xx driver uses the DA8XX_SYSCFG0_VIRT macro to
access the CFGCHIP2 register for controlling its PHY.

The macro in turn relies on the da8xx_syscfg0_base global
variable. Since the OHCI driver can be a loadable module,
this requires the symbol to be exported from platform code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source at linux.davincidsp.com
---
 arch/arm/mach-davinci/devices-da8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 0486cdf..4da868a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -66,6 +66,7 @@
 #define DA850_DMA_MMCSD1_TX	EDMA_CTLR_CHAN(1, 29)
 
 void __iomem *da8xx_syscfg0_base;
+EXPORT_SYMBOL_GPL(da8xx_syscfg0_base); /* used by OHCI_HCD */
 void __iomem *da8xx_syscfg1_base;
 
 static struct plat_serial8250_port da8xx_serial0_pdata[] = {
-- 
1.8.3.2
