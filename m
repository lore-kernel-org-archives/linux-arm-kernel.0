From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 11 Jul 2017 23:21:25 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add Denali NAND controller nodes
In-Reply-To: <1499782885-29023-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499782885-29023-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1499782885-29023-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND controller node to LD11 and LD20.  Neither of them supports
the CS1 line, so pinctrl is set up for a single CS line.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index bdce5b89baec..ca7eb49aa83d 100644
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
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index de1e75362817..1110be4c88ca 100644
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
