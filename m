From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Jan 2017 19:10:27 +0100
Subject: [PATCH v4 8/9] ARM64: dts: amlogic: add the ethernet TX delay
 configuration
In-Reply-To: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
References: <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170122181028.5014-9-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the amlogic,tx-delay-ns property with the old (hardcoded)
default value of 2ns to all boards which are using an RGMII ethernet
PHY.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts    | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts        | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts   | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts   | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts    | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts         | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index dc469cd63bb7..c951e950131c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -148,6 +148,8 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 
+	amlogic,tx-delay-ns = <2>;
+
 	mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 666dd1f32f55..a931111152ea 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -58,6 +58,8 @@
 	phy-handle = <&eth_phy0>;
 	phy-mode = "rgmii";
 
+	amlogic,tx-delay-ns = <2>;
+
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 9bb9cf765076..068b385dc05d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -119,6 +119,8 @@
 	phy-handle = <&eth_phy0>;
 	phy-mode = "rgmii";
 
+	amlogic,tx-delay-ns = <2>;
+
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index ad9eb3efa3ec..c683663d6a8c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -72,6 +72,8 @@
 	phy-handle = <&eth_phy0>;
 	phy-mode = "rgmii";
 
+	amlogic,tx-delay-ns = <2>;
+
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index c1392ed8dd4c..00e92d5e3d3c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -94,6 +94,8 @@
 	phy-handle = <&eth_phy0>;
 	phy-mode = "rgmii";
 
+	amlogic,tx-delay-ns = <2>;
+
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index f66939cacd37..7663d6775823 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -59,6 +59,8 @@
 	/* Select external PHY by default */
 	phy-handle = <&external_phy>;
 
+	amlogic,tx-delay-ns = <2>;
+
 	/* External PHY reset is shared with internal PHY Led signals */
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 804e8de80f37..aa50c923cf36 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -117,6 +117,8 @@
 	/* Select external PHY by default */
 	phy-handle = <&external_phy>;
 
+	amlogic,tx-delay-ns = <2>;
+
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
index 5dbc66088355..e6ac39b712b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
@@ -59,6 +59,8 @@
 	/* Select external PHY by default */
 	phy-handle = <&external_phy>;
 
+	amlogic,tx-delay-ns = <2>;
+
 	/* External PHY reset is shared with internal PHY Led signals */
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
-- 
2.11.0
