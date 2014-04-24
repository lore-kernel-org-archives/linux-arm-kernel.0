From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Apr 2014 12:25:31 +0200
Subject: [PATCH 4/4] ARM: S3C24XX: move debug-macro.S into the common space
In-Reply-To: <1544889.hRy2JpKRQe@phil>
References: <1544889.hRy2JpKRQe@phil>
Message-ID: <6084590.jRjH60327d@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move debug-macro.S from mach/include to include/debug where all other common
debug macros are.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig.debug                                                   | 1 +
 .../{mach-s3c24xx/include/mach/debug-macro.S => include/debug/s3c24xx.S} | 0
 2 files changed, 1 insertion(+)
 rename arch/arm/{mach-s3c24xx/include/mach/debug-macro.S => include/debug/s3c24xx.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 2476f84..00d3ee6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -996,6 +996,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6SL_UART
 	default "debug/msm.S" if DEBUG_MSM_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
+	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
 	default "debug/sti.S" if DEBUG_STI_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
diff --git a/arch/arm/mach-s3c24xx/include/mach/debug-macro.S b/arch/arm/include/debug/s3c24xx.S
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/debug-macro.S
rename to arch/arm/include/debug/s3c24xx.S
-- 
1.9.0
