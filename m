From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 24 Apr 2018 13:47:03 +0900
Subject: [PATCH 4/4] arm64: dts: uniphier: add syscon-phy-mode property to
 each ethernet node
In-Reply-To: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1524545223-5893-5-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add syscon-phy-mode property specifying a phandle of system controller
to each ethernet node.

In addition, LD11 SoC has a built-in ethernet PHY. When we set "internal"
to phy-mode property, this built-in PHY is available.
This patch changes phy-mode property for LD11 to "internal", as default.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 1 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 540e012..cbc4f4b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -553,8 +553,9 @@
 			clocks = <&sys_clk 6>;
 			reset-names = "ether";
 			resets = <&sys_rst 6>;
-			phy-mode = "rmii";
+			phy-mode = "internal";
 			local-mac-address = [00 00 00 00 00 00];
+			socionext,syscon-phy-mode = <&soc_glue 0>;
 
 			mdio: mdio {
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 845b407..1721d45 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -610,6 +610,7 @@
 			resets = <&sys_rst 6>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
+			socionext,syscon-phy-mode = <&soc_glue 0>;
 
 			mdio: mdio {
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 4ff043e..c703842 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -341,7 +341,7 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
-		soc-glue at 5f800000 {
+		soc_glue: soc-glue at 5f800000 {
 			compatible = "socionext,uniphier-pxs3-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -418,6 +418,7 @@
 			resets = <&sys_rst 6>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
+			socionext,syscon-phy-mode = <&soc_glue 0>;
 
 			mdio0: mdio {
 				#address-cells = <1>;
@@ -438,6 +439,7 @@
 			resets = <&sys_rst 7>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
+			socionext,syscon-phy-mode = <&soc_glue 1>;
 
 			mdio1: mdio {
 				#address-cells = <1>;
-- 
2.7.4
