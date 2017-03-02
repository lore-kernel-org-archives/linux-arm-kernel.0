From: pbrobinson@gmail.com (Peter Robinson)
Date: Thu,  2 Mar 2017 17:43:57 +0000
Subject: [PATCH] clk: sunxi-ng: tighten SoC deps on explicit AllWinner SoCs
Message-ID: <20170302174357.6246-1-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tighten the depends on the various AllWinn SoCs so we don't
inadvertantly get clock drivers when we're not wanting them
like 32 bit SoC clocks for 64 bit configs. Ensure there's
still test coverage though.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/clk/sunxi-ng/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 695bbf9..8ab378e 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -63,6 +63,7 @@ config SUN50I_A64_CCU
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
 	default ARM64 && ARCH_SUNXI
+	depends (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 
 config SUN5I_CCU
 	bool "Support for the Allwinner sun5i family CCM"
@@ -74,6 +75,7 @@ config SUN5I_CCU
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
 	default MACH_SUN5I
+	depends MACH_SUN5I || COMPILE_TEST
 
 config SUN6I_A31_CCU
 	bool "Support for the Allwinner A31/A31s CCU"
@@ -84,6 +86,7 @@ config SUN6I_A31_CCU
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
 	default MACH_SUN6I
+	depends MACH_SUN6I || COMPILE_TEST
 
 config SUN8I_A23_CCU
 	bool "Support for the Allwinner A23 CCU"
@@ -96,6 +99,7 @@ config SUN8I_A23_CCU
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
+	depends MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_A33_CCU
 	bool "Support for the Allwinner A33 CCU"
@@ -108,6 +112,7 @@ config SUN8I_A33_CCU
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
+	depends MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_H3_CCU
 	bool "Support for the Allwinner H3 CCU"
@@ -119,6 +124,7 @@ config SUN8I_H3_CCU
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
+	depends MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_V3S_CCU
 	bool "Support for the Allwinner V3s CCU"
@@ -130,6 +136,7 @@ config SUN8I_V3S_CCU
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
+	depends MACH_SUN8I || COMPILE_TEST
 
 config SUN9I_A80_CCU
 	bool "Support for the Allwinner A80 CCU"
@@ -140,5 +147,6 @@ config SUN9I_A80_CCU
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
 	default MACH_SUN9I
+	depends MACH_SUN9I || COMPILE_TEST
 
 endif
-- 
2.9.3
