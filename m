From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  1 Mar 2017 01:24:40 +0800
Subject: [PATCH 1/5] pinctrl: sunxi: refactor pinctrl choice selecting for
 ARM64
Message-ID: <20170228172444.59655-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 Allwinner SoCs used to have every pinctrl driver selected in
ARCH_SUNXI. Change this to make their default value to (ARM64 &&
ARCH_SUNXI).

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/pinctrl/sunxi/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 816015cf7053..92325736d953 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -48,8 +48,9 @@ config PINCTRL_SUN8I_H3
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_H3_R
-	def_bool MACH_SUN8I
-	select PINCTRL_SUNXI_COMMON
+	def_bool MACH_SUN8I || (ARM64 && ARCH_SUNXI)
+	depends on RESET_CONTROLLER
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_V3S
 	def_bool MACH_SUN8I
@@ -65,11 +66,11 @@ config PINCTRL_SUN9I_A80_R
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN50I_A64
-	bool
+	def_bool ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN50I_H5
-	bool
+	def_bool ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
 endif
-- 
2.11.1
