From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 21 Apr 2016 11:11:23 +0900
Subject: [PATCH v2] ARM: dts: uniphier: add NAND pinmux node
Message-ID: <1461204683-28753-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds pin-mux nodes for the NAND controller.
Some SoCs support 2 chip selects and the others only support
1 chip select.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add pinctrl_nand2cs node (NAND with 2 chip selects)

 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 2459279..f2f3fbe 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -68,6 +68,16 @@
 		function = "i2c4";
 	};
 
+	pinctrl_nand: nand_grp {
+		groups = "nand";
+		function = "nand";
+	};
+
+	pinctrl_nand2cs: nand2cs_grp {
+		groups = "nand", "nand_cs1";
+		function = "nand";
+	};
+
 	pinctrl_uart0: uart0_grp {
 		groups = "uart0";
 		function = "uart0";
-- 
1.9.1
