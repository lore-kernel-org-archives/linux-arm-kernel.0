From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 15:00:45 +0900
Subject: [PATCH] pinctrl: uniphier: rework UniPhier pinctrl entries in Kconfig
Message-ID: <1448344846-28726-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a plan to support more pinctrl drivers for this SoC family.
Move the driver entries into a sub menu by using "menuconfig".
Also, add the missing dependency "depends on OF && MFD_SYSCON".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/Kconfig | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/uniphier/Kconfig b/drivers/pinctrl/uniphier/Kconfig
index ad90707..7abd614 100644
--- a/drivers/pinctrl/uniphier/Kconfig
+++ b/drivers/pinctrl/uniphier/Kconfig
@@ -1,32 +1,35 @@
-if ARCH_UNIPHIER
-
-config PINCTRL_UNIPHIER
-	bool
+menuconfig PINCTRL_UNIPHIER
+	bool "UniPhier SoC pinctrl drivers"
+	depends on ARCH_UNIPHIER
+	depends on OF && MFD_SYSCON
+	default y
 	select PINMUX
 	select GENERIC_PINCONF
 
+if PINCTRL_UNIPHIER
+
 config PINCTRL_UNIPHIER_PH1_LD4
 	tristate "UniPhier PH1-LD4 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER
+	default y
 
 config PINCTRL_UNIPHIER_PH1_PRO4
 	tristate "UniPhier PH1-Pro4 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER
+	default y
 
 config PINCTRL_UNIPHIER_PH1_SLD8
 	tristate "UniPhier PH1-sLD8 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER
+	default y
 
 config PINCTRL_UNIPHIER_PH1_PRO5
 	tristate "UniPhier PH1-Pro5 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER
+	default y
 
 config PINCTRL_UNIPHIER_PROXSTREAM2
 	tristate "UniPhier ProXstream2 SoC pinctrl driver"
-	select PINCTRL_UNIPHIER
+	default y
 
 config PINCTRL_UNIPHIER_PH1_LD6B
 	tristate "UniPhier PH1-LD6b SoC pinctrl driver"
-	select PINCTRL_UNIPHIER
+	default y
 
 endif
-- 
1.9.1
