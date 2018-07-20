From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 20 Jul 2018 17:50:45 +0900
Subject: [PATCH 2/2] arm64: uniphier: dts: add more clocks to Denali NAND
 controller node
In-Reply-To: <1532076645-10769-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532076645-10769-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1532076645-10769-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catch up with the new binding of the Denali IP where three clocks,
"nand", "nand_x", "ecc" are required.

For UniPhier SoCs, the "nand_x" and "ecc" are tied up because they
are both 200MHz.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index d63b56e..5640dac 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -571,7 +571,8 @@
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			clocks = <&sys_clk 2>;
+			clock-names = "nand", "nand_x", "ecc";
+			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 0298bd0..a8964c0 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -626,7 +626,8 @@
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			clocks = <&sys_clk 2>;
+			clock-names = "nand", "nand_x", "ecc";
+			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 2a4cf42..fd2bcd4 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -455,7 +455,8 @@
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-			clocks = <&sys_clk 2>;
+			clock-names = "nand", "nand_x", "ecc";
+			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
 	};
-- 
2.7.4
