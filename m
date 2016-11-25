From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 25 Nov 2016 14:01:52 +0100
Subject: [PATCH v2 3/7] ARM64: dts: meson-gx: move the MDIO node to meson-gx
In-Reply-To: <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161125130156.17879-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stmmac's MDIO bus is currently only defined in meson-gxl.dtsi. Move it
up to meson-gx to allow us to keep the stmmac configuration for
meson-gxbb similar to the configuration on meson-gxl.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 47ab306..a2c3ca6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -371,6 +371,12 @@
 			interrupt-names = "macirq";
 			phy-mode = "rgmii";
 			status = "disabled";
+
+			mdio0: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
 		};
 
 		apb: apb at d0000000 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 3af54dc..aa3cd80 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -57,12 +57,6 @@
 		 <&clkc CLKID_FCLK_DIV2>,
 		 <&clkc CLKID_MPLL2>;
 	clock-names = "stmmaceth", "clkin0", "clkin1";
-
-	mdio0: mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-	};
 };
 
 &aobus {
-- 
2.10.2
