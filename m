From: khilman@ti.com (Kevin Hilman)
Date: Thu,  4 Aug 2011 08:45:07 -0700
Subject: [PATCH 3/6] OMAP1: enable GENERIC_IRQ_CHIP
In-Reply-To: <1312472710-31758-1-git-send-email-khilman@ti.com>
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
Message-ID: <1312472710-31758-4-git-send-email-khilman@ti.com>
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
1.7.6
