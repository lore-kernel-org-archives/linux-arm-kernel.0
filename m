From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 19 Feb 2017 22:41:48 +0100
Subject: [PATCH v5 8/9] ARM64: dts: amlogic: add the ethernet TX delay
 configuration
In-Reply-To: <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
References: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170219214149.30418-9-martin.blumenstingl@googlemail.com>
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
index 6b5579522587..c80d3a913907 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -158,6 +158,8 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 
+	amlogic,tx-delay-ns = <2>;
+
 	mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index acb035d119d7..2054a474e0a9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -103,6 +103,8 @@
 	phy-handle = <&eth_phy0>;
 	phy-mode = "rgmii";
 
+	amlogic,tx-delay-ns = <2>;
+
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index aa571970c5e9..aefa66dff72d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -131,6 +131,8 @@
 	phy-handle = <&eth_phy0>;
 	phy-mode = "rgmii";
 
+	amlogic,tx-delay-ns = <2>;
+
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index 50eb8f06d35b..f057fb48fee5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -73,6 +73,8 @@
 	phy-handle = <&eth_phy0>;
 	phy-mode = "rgmii";
 
+	amlogic,tx-delay-ns = <2>;
+
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index ee86af928722..743acb5f5d06 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -95,6 +95,8 @@
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
index 5a337d339df1..a0bc746adb42 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -162,6 +162,8 @@
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
2.11.1
