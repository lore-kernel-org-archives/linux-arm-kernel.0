From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Feb 2014 20:38:17 +0100
Subject: [PATCH v2 1/2] ARM: SAMSUNG: use generic uncompress.h
In-Reply-To: <6973248.vNO4T7GhE6@phil>
References: <6973248.vNO4T7GhE6@phil>
Message-ID: <2544454.5zxXse5cEm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Samsung platforms, not only Exynos, use the custom uncompress.h
simply to setup the uart for the initial debug output. This can also
be done using the generic uncompress.h.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 3e988f6..a160744 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1145,7 +1145,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 
 config DEBUG_UNCOMPRESS
 	bool
-	depends on ARCH_MULTIPLATFORM || ARCH_MSM || ARCH_EXYNOS
+	depends on ARCH_MULTIPLATFORM || ARCH_MSM || PLAT_SAMSUNG
 	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
 	help
@@ -1162,7 +1162,7 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					ARCH_EXYNOS
+					PLAT_SAMSUNG
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
-- 
1.8.5.3
