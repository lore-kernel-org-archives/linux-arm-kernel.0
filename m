From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 17:00:58 +0800
Subject: [PATCH 2/3] ARM: mxs: rename debug-macro.S for multiplatform build
In-Reply-To: <1364547659-30574-1-git-send-email-shawn.guo@linaro.org>
References: <1364547659-30574-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547659-30574-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename arch/arm/mach-mxs/include/mach/debug-macro.S to
arch/arm/include/debug/mxs.S for multiplatform build.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug                             |    1 +
 .../mach/debug-macro.S => include/debug/mxs.S}     |    0
 2 files changed, 1 insertion(+)
 rename arch/arm/{mach-mxs/include/mach/debug-macro.S => include/debug/mxs.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ecfcdba..6b377f2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -590,6 +590,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6Q_UART
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
+	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
diff --git a/arch/arm/mach-mxs/include/mach/debug-macro.S b/arch/arm/include/debug/mxs.S
similarity index 100%
rename from arch/arm/mach-mxs/include/mach/debug-macro.S
rename to arch/arm/include/debug/mxs.S
-- 
1.7.9.5
