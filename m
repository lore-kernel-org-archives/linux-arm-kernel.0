From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 01:43:31 +0900
Subject: [PATCH 6/6] arm64: dts: uniphier: add Denali NAND controller nodes
In-Reply-To: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
References: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1502297011-30201-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND controller node to LD11 and LD20.  Neither of them supports
the CS1 line, so pinctrl is set up for a single CS line.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts |  4 ++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  4 ++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 11 +++++++++++
 4 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index ffb473ad2e0f..d80d4c999157 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -62,3 +62,7 @@
 &usb2 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index e420268295d9..d85f058b55d1 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -368,6 +368,17 @@
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
+			pinctrl-0 = <&pinctrl_nand>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 1ca0c8620dc5..fd6d2cae3b3e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -50,3 +50,7 @@
 &i2c0 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 5cdd7a9db412..0c4bcdcac0db 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -389,6 +389,17 @@
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
+			pinctrl-0 = <&pinctrl_nand>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
-- 
2.7.4
