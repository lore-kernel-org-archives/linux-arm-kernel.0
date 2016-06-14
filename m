From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jun 2016 11:59:44 +0900
Subject: [PATCH 1/3] ARM: dts: uniphier: add System Bus pinmux node
In-Reply-To: <1465873186-30658-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465873186-30658-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465873186-30658-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pin-muxing is needed to get access to the UniPhier System Bus.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-common32.dtsi | 2 ++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi  | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-common32.dtsi b/arch/arm/boot/dts/uniphier-common32.dtsi
index 61a0955..891327f 100644
--- a/arch/arm/boot/dts/uniphier-common32.dtsi
+++ b/arch/arm/boot/dts/uniphier-common32.dtsi
@@ -105,6 +105,8 @@
 			reg = <0x58c00000 0x400>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_system_bus>;
 		};
 
 		smpctrl at 59800000 {
diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index f2f3fbe..10a7110 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -78,6 +78,11 @@
 		function = "nand";
 	};
 
+	pinctrl_system_bus: system_bus_grp {
+		groups = "system_bus", "system_bus_cs1";
+		function = "system_bus";
+	};
+
 	pinctrl_uart0: uart0_grp {
 		groups = "uart0";
 		function = "uart0";
-- 
1.9.1
