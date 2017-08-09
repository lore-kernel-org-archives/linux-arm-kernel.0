From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 01:43:30 +0900
Subject: [PATCH 5/6] ARM: dts: uniphier: add Denali NAND controller node
In-Reply-To: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
References: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1502297011-30201-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND controller node to LD4, Pro4, sLD8, Pro5, and PXs2.
Set up pinctrl to enable 2 chip select lines except Pro4.  The CS1
for Pro4 is multiplexed with other peripherals such as UART2, so
I did not enable it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts  |  4 ++++
 arch/arm/boot/dts/uniphier-ld4.dtsi     | 11 +++++++++++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts |  4 ++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts |  4 ++++
 arch/arm/boot/dts/uniphier-pro4.dtsi    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-sld8-ref.dts |  4 ++++
 arch/arm/boot/dts/uniphier-sld8.dtsi    | 11 +++++++++++
 9 files changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index 86b089e9c163..b3aaab354f3e 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -64,3 +64,7 @@
 &usb1 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 5d3924c8568c..91410609b181 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -285,6 +285,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "socionext,uniphier-denali-nand-v5a";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand2cs>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 6dbdc86225e9..2188d114d79b 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -58,3 +58,7 @@
 &i2c0 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index d3be37b2ac35..903df6348e77 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -66,3 +66,7 @@
 &usb3 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 394b35e1082d..1d3d00d9c936 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -305,6 +305,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "denali,denali-nand-uniphier-v5a";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index df0506b58330..759c2a53c29d 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -368,6 +368,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "denali,denali-nand-uniphier-v5b";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand2cs>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index c26d4ba1b9c3..ed2b9a4516aa 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -352,6 +352,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "socionext,uniphier-denali-nand-v5b";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand2cs>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index 394f5df62eda..5accd3cc76e4 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -68,3 +68,7 @@
 &usb2 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 0c022fa5640c..756fed778de6 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -285,6 +285,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "denali,denali-nand-uniphier-v5a";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand2cs>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
-- 
2.7.4
