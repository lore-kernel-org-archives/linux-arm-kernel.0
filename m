From: khilman@ti.com (Kevin Hilman)
Date: Tue,  7 Jun 2011 17:02:46 -0700
Subject: [PATCH] OMAP1: enable GENERIC_IRQ_CHIP
Message-ID: <1307491366-28793-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP1 needs this also since GPIO driver (common for all OMAPs) is
being converted to use generic IRQ chip.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 49a4c75..9a4a6bf 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -13,6 +13,7 @@ config ARCH_OMAP1
 	bool "TI OMAP1"
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
-- 
1.7.4
