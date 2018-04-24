From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 24 Apr 2018 13:47:02 +0900
Subject: [PATCH 3/4] ARM: dts: uniphier: add syscon-phy-mode property to each
 ethernet node
In-Reply-To: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1524545223-5893-4-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add syscon-phy-mode property specifying a phandle of system controller
to each ethernet node.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro4.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 392d7dd..49539f0 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -286,7 +286,7 @@
 			has-transaction-translator;
 		};
 
-		soc-glue at 5f800000 {
+		soc_glue: soc-glue at 5f800000 {
 			compatible = "socionext,uniphier-pro4-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -378,6 +378,7 @@
 			resets = <&sys_rst 12>, <&sys_rst 6>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
+			socionext,syscon-phy-mode = <&soc_glue 0>;
 
 			mdio: mdio {
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index a1839db..641d961 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -512,6 +512,7 @@
 			resets = <&sys_rst 6>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
+			socionext,syscon-phy-mode = <&soc_glue 0>;
 
 			mdio: mdio {
 				#address-cells = <1>;
-- 
2.7.4
