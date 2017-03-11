From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 12 Mar 2017 00:38:05 +0900
Subject: [PATCH] arm64: dts: uniphier: add pinctrl property to eMMC node for
 LD11/LD20
Message-ID: <1489246685-8264-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now everything is ready to enable this pinctrl.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 2ed35e3..4b54b56 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -304,6 +304,8 @@
 			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 			reg = <0x5a000000 0x400>;
 			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sys_clk 4>;
 			bus-width = <8>;
 			mmc-ddr-1_8v;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 96c053f..6193f11 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -378,6 +378,8 @@
 			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 			reg = <0x5a000000 0x400>;
 			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sys_clk 4>;
 			bus-width = <8>;
 			mmc-ddr-1_8v;
-- 
2.7.4
