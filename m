From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  2 Mar 2016 15:14:40 +0900
Subject: [PATCH] pinctrl: uniphier: rename CONFIG options and file names
Message-ID: <1456899280-8641-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current "CONFIG_PINCTRL_UNIPHIER_PH1_*" is too long.  It would
not hurt to drop "PH1_" because "UNIPHIER_" already well specifies
the SoC family.  Also, rename files for consistency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/Kconfig                           | 12 ++++++------
 drivers/pinctrl/uniphier/Makefile                          | 14 +++++++-------
 .../uniphier/{pinctrl-ph1-ld4.c => pinctrl-uniphier-ld4.c} |  0
 .../{pinctrl-ph1-ld6b.c => pinctrl-uniphier-ld6b.c}        |  0
 .../{pinctrl-ph1-pro4.c => pinctrl-uniphier-pro4.c}        |  0
 .../{pinctrl-ph1-pro5.c => pinctrl-uniphier-pro5.c}        |  0
 .../{pinctrl-proxstream2.c => pinctrl-uniphier-pxs2.c}     |  0
 .../{pinctrl-ph1-sld8.c => pinctrl-uniphier-sld8.c}        |  0
 8 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/pinctrl/uniphier/{pinctrl-ph1-ld4.c => pinctrl-uniphier-ld4.c} (100%)
 rename drivers/pinctrl/uniphier/{pinctrl-ph1-ld6b.c => pinctrl-uniphier-ld6b.c} (100%)
 rename drivers/pinctrl/uniphier/{pinctrl-ph1-pro4.c => pinctrl-uniphier-pro4.c} (100%)
 rename drivers/pinctrl/uniphier/{pinctrl-ph1-pro5.c => pinctrl-uniphier-pro5.c} (100%)
 rename drivers/pinctrl/uniphier/{pinctrl-proxstream2.c => pinctrl-uniphier-pxs2.c} (100%)
 rename drivers/pinctrl/uniphier/{pinctrl-ph1-sld8.c => pinctrl-uniphier-sld8.c} (100%)

diff --git a/drivers/pinctrl/uniphier/Kconfig b/drivers/pinctrl/uniphier/Kconfig
index 43f689f..0b40ded 100644
--- a/drivers/pinctrl/uniphier/Kconfig
+++ b/drivers/pinctrl/uniphier/Kconfig
@@ -8,27 +8,27 @@ menuconfig PINCTRL_UNIPHIER
 
 if PINCTRL_UNIPHIER
 
-config PINCTRL_UNIPHIER_PH1_LD4
+config PINCTRL_UNIPHIER_LD4
 	tristate "UniPhier PH1-LD4 SoC pinctrl driver"
 	default y
 
-config PINCTRL_UNIPHIER_PH1_PRO4
+config PINCTRL_UNIPHIER_PRO4
 	tristate "UniPhier PH1-Pro4 SoC pinctrl driver"
 	default y
 
-config PINCTRL_UNIPHIER_PH1_SLD8
+config PINCTRL_UNIPHIER_SLD8
 	tristate "UniPhier PH1-sLD8 SoC pinctrl driver"
 	default y
 
-config PINCTRL_UNIPHIER_PH1_PRO5
+config PINCTRL_UNIPHIER_PRO5
 	tristate "UniPhier PH1-Pro5 SoC pinctrl driver"
 	default y
 
-config PINCTRL_UNIPHIER_PROXSTREAM2
+config PINCTRL_UNIPHIER_PXS2
 	tristate "UniPhier ProXstream2 SoC pinctrl driver"
 	default y
 
-config PINCTRL_UNIPHIER_PH1_LD6B
+config PINCTRL_UNIPHIER_LD6B
 	tristate "UniPhier PH1-LD6b SoC pinctrl driver"
 	default y
 
diff --git a/drivers/pinctrl/uniphier/Makefile b/drivers/pinctrl/uniphier/Makefile
index e7ce967..3b8f9ee 100644
--- a/drivers/pinctrl/uniphier/Makefile
+++ b/drivers/pinctrl/uniphier/Makefile
@@ -1,8 +1,8 @@
-obj-y						+= pinctrl-uniphier-core.o
+obj-y					+= pinctrl-uniphier-core.o
 
-obj-$(CONFIG_PINCTRL_UNIPHIER_PH1_LD4)		+= pinctrl-ph1-ld4.o
-obj-$(CONFIG_PINCTRL_UNIPHIER_PH1_PRO4)		+= pinctrl-ph1-pro4.o
-obj-$(CONFIG_PINCTRL_UNIPHIER_PH1_SLD8)		+= pinctrl-ph1-sld8.o
-obj-$(CONFIG_PINCTRL_UNIPHIER_PH1_PRO5)		+= pinctrl-ph1-pro5.o
-obj-$(CONFIG_PINCTRL_UNIPHIER_PROXSTREAM2)	+= pinctrl-proxstream2.o
-obj-$(CONFIG_PINCTRL_UNIPHIER_PH1_LD6B)		+= pinctrl-ph1-ld6b.o
+obj-$(CONFIG_PINCTRL_UNIPHIER_LD4)	+= pinctrl-uniphier-ld4.o
+obj-$(CONFIG_PINCTRL_UNIPHIER_PRO4)	+= pinctrl-uniphier-pro4.o
+obj-$(CONFIG_PINCTRL_UNIPHIER_SLD8)	+= pinctrl-uniphier-sld8.o
+obj-$(CONFIG_PINCTRL_UNIPHIER_PRO5)	+= pinctrl-uniphier-pro5.o
+obj-$(CONFIG_PINCTRL_UNIPHIER_PXS2)	+= pinctrl-uniphier-pxs2.o
+obj-$(CONFIG_PINCTRL_UNIPHIER_LD6B)	+= pinctrl-uniphier-ld6b.o
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
similarity index 100%
rename from drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
rename to drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
similarity index 100%
rename from drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
rename to drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
similarity index 100%
rename from drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
rename to drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
similarity index 100%
rename from drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
rename to drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
diff --git a/drivers/pinctrl/uniphier/pinctrl-proxstream2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
similarity index 100%
rename from drivers/pinctrl/uniphier/pinctrl-proxstream2.c
rename to drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
diff --git a/drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
similarity index 100%
rename from drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
rename to drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
-- 
1.9.1
