From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 24 Jan 2016 00:33:24 +0900
Subject: [PATCH] pinctrl: mediatek: guard sub-directory with CONFIG_PINCTRL_MTK
Message-ID: <1453563204-30407-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PINCTRL_MTK is more suitable than CONFIG_ARCH_MEDIATEK
to guard the drivers/pinctrl/mediatek/ directory.
(I renamed CONFIG_PINCTRL_MTK_COMMON to CONFIG_PINCTRL_MTK.)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/Makefile          |  2 +-
 drivers/pinctrl/mediatek/Kconfig  | 10 +++++-----
 drivers/pinctrl/mediatek/Makefile | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 63a6f0b..ab512c4 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -48,4 +48,4 @@ obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
-obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
+obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 02f6f92..3cfa705 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -1,6 +1,6 @@
 if ARCH_MEDIATEK || COMPILE_TEST
 
-config PINCTRL_MTK_COMMON
+config PINCTRL_MTK
 	bool
 	depends on OF
 	select PINMUX
@@ -13,13 +13,13 @@ config PINCTRL_MT8135
 	bool "Mediatek MT8135 pin control" if COMPILE_TEST && !MACH_MT8135
 	depends on OF
 	default MACH_MT8135
-	select PINCTRL_MTK_COMMON
+	select PINCTRL_MTK
 
 config PINCTRL_MT8127
 	bool "Mediatek MT8127 pin control" if COMPILE_TEST && !MACH_MT8127
 	depends on OF
 	default MACH_MT8127
-	select PINCTRL_MTK_COMMON
+	select PINCTRL_MTK
 
 # For ARMv8 SoCs
 config PINCTRL_MT8173
@@ -27,13 +27,13 @@ config PINCTRL_MT8173
 	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	default ARM64 && ARCH_MEDIATEK
-	select PINCTRL_MTK_COMMON
+	select PINCTRL_MTK
 
 # For PMIC
 config PINCTRL_MT6397
 	bool "Mediatek MT6397 pin control" if COMPILE_TEST && !MFD_MT6397
 	depends on OF
 	default MFD_MT6397
-	select PINCTRL_MTK_COMMON
+	select PINCTRL_MTK
 
 endif
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index eb923d6..2419ce5 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -1,8 +1,8 @@
 # Core
-obj-$(CONFIG_PINCTRL_MTK_COMMON)	+= pinctrl-mtk-common.o
+obj-y				+= pinctrl-mtk-common.o
 
 # SoC Drivers
-obj-$(CONFIG_PINCTRL_MT8135)		+= pinctrl-mt8135.o
-obj-$(CONFIG_PINCTRL_MT8127)		+= pinctrl-mt8127.o
-obj-$(CONFIG_PINCTRL_MT8173)		+= pinctrl-mt8173.o
-obj-$(CONFIG_PINCTRL_MT6397)		+= pinctrl-mt6397.o
+obj-$(CONFIG_PINCTRL_MT8135)	+= pinctrl-mt8135.o
+obj-$(CONFIG_PINCTRL_MT8127)	+= pinctrl-mt8127.o
+obj-$(CONFIG_PINCTRL_MT8173)	+= pinctrl-mt8173.o
+obj-$(CONFIG_PINCTRL_MT6397)	+= pinctrl-mt6397.o
-- 
1.9.1
