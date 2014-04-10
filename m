From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu, 10 Apr 2014 15:07:54 +0200
Subject: [PATCH RESEND 5/5] ARM: dts: berlin: add the pinctrl node and muxing
 setup for uarts
In-Reply-To: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397135274-10764-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uart0 pinmux configuration is in the dtsi because uart0 will always
use uart0-pmux to work, no other possibility. Same thing for uart1.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi   | 20 ++++++++++++++++++++
 arch/arm/boot/dts/berlin2cd.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/berlin2q.dtsi  | 20 ++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 56a1af2f1052..43eb90c36050 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -176,6 +176,22 @@
 			};
 		};
 
+		pinctrl: pinctrl at 0 {
+			compatible = "marvell,berlin2-pinctrl";
+			reg = <0xea0000 0x08>, <0xfc0000 0x44>;
+			reg-names = "global_base", "apb_base";
+
+			uart0_pmux: uart0-pmux {
+				berlin,group = "GSM4";
+				berlin,function = <0>;
+			};
+
+			uart1_pmux: uart1-pmux {
+				berlin,group = "GSM5";
+				berlin,function = <1>;
+			};
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -191,6 +207,8 @@
 				reg-io-width = <1>;
 				interrupts = <8>;
 				clocks = <&smclk>;
+				pinctrl-0 = <&uart0_pmux>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 
@@ -201,6 +219,8 @@
 				reg-io-width = <1>;
 				interrupts = <9>;
 				clocks = <&smclk>;
+				pinctrl-0 = <&uart1_pmux>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 094968c27533..4c04cff89226 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -169,6 +169,17 @@
 			};
 		};
 
+		pinctrl: pinctrl at 0 {
+			compatible = "marvell,berlin2cd-pinctrl";
+			reg = <0xea0000 0x08>, <0xfc0000 0x44>;
+			reg-names = "global_base", "apb_base";
+
+			uart0_pmux: uart0-pmux {
+				berlin,group = "G6";
+				berlin,function = <0>;
+			};
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -184,6 +195,8 @@
 				reg-io-width = <1>;
 				interrupts = <8>;
 				clocks = <&smclk>;
+				pinctrl-0 = <&uart0_pmux>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 07452a7483fa..e6e556055dfc 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -183,6 +183,22 @@
 			};
 		};
 
+		pinctrl: pinctrl at 0 {
+			compatible = "marvell,berlin2q-pinctrl";
+			reg = <0xea0000 0x4c>, <0xfcd000 0x44>;
+			reg-names = "global_base", "sm_base";
+
+			uart0_pmux: uart0-pmux {
+				berlin,group = "GSM12";
+				berlin,function = <0>;
+			};
+
+			uart1_pmux: uart1-pmux {
+				berlin,group = "GSM14";
+				berlin,function = <1>;
+			};
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -198,6 +214,8 @@
 				interrupts = <8>;
 				clocks = <&smclk>;
 				reg-shift = <2>;
+				pinctrl-0 = <&uart0_pmux>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 
@@ -208,6 +226,8 @@
 				interrupts = <9>;
 				clocks = <&smclk>;
 				reg-shift = <2>;
+				pinctrl-0 = <&uart1_pmux>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 
-- 
1.8.3.2
