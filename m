From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 16 Feb 2014 18:33:17 +0100
Subject: [PATCH 1/2] ARM: SAMSUNG: use generic uncompress.h
In-Reply-To: <3594365.ORKU4Q2jDp@phil>
References: <3594365.ORKU4Q2jDp@phil>
Message-ID: <9414533.cBWCZj35Zp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Samsung platforms use the custom uncompress.h simply to setup the uart
for the initial debug output. This can also be done using the generic
uncompress.h.

Suggested-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig.debug | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0531da8..a160744 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1145,7 +1145,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 
 config DEBUG_UNCOMPRESS
 	bool
-	depends on ARCH_MULTIPLATFORM || ARCH_MSM
+	depends on ARCH_MULTIPLATFORM || ARCH_MSM || PLAT_SAMSUNG
 	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
 	help
@@ -1161,7 +1161,8 @@ config DEBUG_UNCOMPRESS
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM
+	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
+					PLAT_SAMSUNG
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
-- 
1.8.5.3
