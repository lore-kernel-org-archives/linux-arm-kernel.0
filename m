From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 24 Jan 2016 00:32:09 +0900
Subject: [PATCH] pinctrl: sunxi: guard sub-directory with CONFIG_PINCTRL_SUNXI
Message-ID: <1453563129-30332-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PINCTRL_SUNXI is more suitable than CONFIG_ARCH_SUNXI
to guard the drivers/pinctrl/sunxi/ directory.
(I renamed CONFIG_PINCTRL_SUNXI_COMMON to CONFIG_PINCTRL_SUNXI.)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/Makefile       |  2 +-
 drivers/pinctrl/sunxi/Kconfig  | 30 +++++++++++++++---------------
 drivers/pinctrl/sunxi/Makefile |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 04b633f..63a6f0b 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc/
 obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
-obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
+obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index f8dbc8b..ac8388e 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -1,67 +1,67 @@
 if ARCH_SUNXI
 
-config PINCTRL_SUNXI_COMMON
+config PINCTRL_SUNXI
 	bool
 	select PINMUX
 	select GENERIC_PINCONF
 
 config PINCTRL_SUN4I_A10
 	def_bool MACH_SUN4I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN5I_A10S
 	def_bool MACH_SUN5I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN5I_A13
 	def_bool MACH_SUN5I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN6I_A31
 	def_bool MACH_SUN6I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN6I_A31S
 	def_bool MACH_SUN6I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN6I_A31_R
 	def_bool MACH_SUN6I
 	depends on RESET_CONTROLLER
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN7I_A20
 	def_bool MACH_SUN7I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_A23
 	def_bool MACH_SUN8I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_A33
 	def_bool MACH_SUN8I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_A83T
 	def_bool MACH_SUN8I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_A23_R
 	def_bool MACH_SUN8I
 	depends on RESET_CONTROLLER
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_H3
 	def_bool MACH_SUN8I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN9I_A80
 	def_bool MACH_SUN9I
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN9I_A80_R
 	def_bool MACH_SUN9I
 	depends on RESET_CONTROLLER
-	select PINCTRL_SUNXI_COMMON
+	select PINCTRL_SUNXI
 
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index ef82f22..dac1bd0 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -1,5 +1,5 @@
 # Core
-obj-$(CONFIG_PINCTRL_SUNXI_COMMON)	+= pinctrl-sunxi.o
+obj-y					+= pinctrl-sunxi.o
 
 # SoC Drivers
 obj-$(CONFIG_PINCTRL_SUN4I_A10)		+= pinctrl-sun4i-a10.o
-- 
1.9.1
