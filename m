From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 12 Mar 2017 00:36:56 +0900
Subject: [PATCH] ARM: dts: uniphier: fix pin groups of eMMC pin-mux node
Message-ID: <1489246616-8060-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC devices on UniPhier boards are generally used in the 8-bit
mode.  So, DAT4-7 pins should be controlled.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 8ee79da..246f35f 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -45,7 +45,7 @@
 
 &pinctrl {
 	pinctrl_emmc: emmc_grp {
-		groups = "emmc";
+		groups = "emmc", "emmc_dat8";
 		function = "emmc";
 	};
 
-- 
2.7.4
