From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 30 Oct 2015 19:28:15 +0900
Subject: [PATCH v2] pinctrl: uniphier: guard uniphier directory with
 CONFIG_PINCTRL_UNIPHIER
Message-ID: <1446200895-29592-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PINCTRL_UNIPHIER is more suitable than CONFIG_ARCH_UNIPHIER
to guard the drivers/pinctrl/uniphier directory.

The current CONFIG_PINCTRL_UNIPHIER_CORE is a bit long
(it would break the indentation in drivers/pinctrl/Makefile),
so rename it into CONFIG_PINCTRL_UNIPHIER.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/Makefile          |  2 +-
 drivers/pinctrl/uniphier/Kconfig  | 14 +++++++-------
 drivers/pinctrl/uniphier/Makefile |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index cad077c..367af9b 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -50,6 +50,6 @@ obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
-obj-$(CONFIG_ARCH_UNIPHIER)	+= uniphier/
+obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
diff --git a/drivers/pinctrl/uniphier/Kconfig b/drivers/pinctrl/uniphier/Kconfig
index eab23ef..ad90707 100644
--- a/drivers/pinctrl/uniphier/Kconfig
+++ b/drivers/pinctrl/uniphier/Kconfig
@@ -1,32 +1,32 @@
 if ARCH_UNIPHIER
 
-config PINCTRL_UNIPHIER_CORE
+config PINCTRL_UNIPHIER
 	bool
 	select PINMUX
 	select GENERIC_PINCONF
 
 config PINCTRL_UNIPHIER_PH1_LD4
 	tristate "UniPhier PH1-LD4 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER_CORE
+	select PINCTRL_UNIPHIER
 
 config PINCTRL_UNIPHIER_PH1_PRO4
 	tristate "UniPhier PH1-Pro4 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER_CORE
+	select PINCTRL_UNIPHIER
 
 config PINCTRL_UNIPHIER_PH1_SLD8
 	tristate "UniPhier PH1-sLD8 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER_CORE
+	select PINCTRL_UNIPHIER
 
 config PINCTRL_UNIPHIER_PH1_PRO5
 	tristate "UniPhier PH1-Pro5 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER_CORE
+	select PINCTRL_UNIPHIER
 
 config PINCTRL_UNIPHIER_PROXSTREAM2
 	tristate "UniPhier ProXstream2 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER_CORE
+	select PINCTRL_UNIPHIER
 
 config PINCTRL_UNIPHIER_PH1_LD6B
 	tristate "UniPhier PH1-LD6b SoC pinctrl driver"
-	select PINCTRL_UNIPHIER_CORE
+	select PINCTRL_UNIPHIER
 
 endif
diff --git a/drivers/pinctrl/uniphier/Makefile b/drivers/pinctrl/uniphier/Makefile
index e215b10..e7ce967 100644
--- a/drivers/pinctrl/uniphier/Makefile
+++ b/drivers/pinctrl/uniphier/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_PINCTRL_UNIPHIER_CORE)		+= pinctrl-uniphier-core.o
+obj-y						+= pinctrl-uniphier-core.o
 
 obj-$(CONFIG_PINCTRL_UNIPHIER_PH1_LD4)		+= pinctrl-ph1-ld4.o
 obj-$(CONFIG_PINCTRL_UNIPHIER_PH1_PRO4)		+= pinctrl-ph1-pro4.o
-- 
1.9.1
