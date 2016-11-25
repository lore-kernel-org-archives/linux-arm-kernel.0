From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 25 Nov 2016 14:01:56 +0100
Subject: [PATCH v2 7/7] ARM64: dts: amlogic: add the ethernet TX delay
 configuration
In-Reply-To: <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161125130156.17879-8-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the amlogic,tx-delay-ns with the old (hardcoded) default value
of 2ns to all boards which are using an RGMII ethernet PHY.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi     | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts  | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts  | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index cbaf024..fdade07 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -161,6 +161,8 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 
+	amlogic,tx-delay-ns = <2>;
+
 	phy-mode = "rgmii";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 2abc553..8172e12 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -152,6 +152,8 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 
+	amlogic,tx-delay-ns = <2>;
+
 	phy-mode = "rgmii";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index a0e92e3..ab49712 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -131,6 +131,8 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 
+	amlogic,tx-delay-ns = <2>;
+
 	phy-mode = "rgmii";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index f66939c..7fd11c6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -64,6 +64,8 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 
+	amlogic,tx-delay-ns = <2>;
+
 	/* External PHY is in RGMII */
 	phy-mode = "rgmii";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index d320727..f83d6dc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -156,6 +156,8 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 
+	amlogic,tx-delay-ns = <2>;
+
 	/* External PHY is in RGMII */
 	phy-mode = "rgmii";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
index 5dbc660..e428e29 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
@@ -64,6 +64,8 @@
 	snps,reset-delays-us = <0 10000 1000000>;
 	snps,reset-active-low;
 
+	amlogic,tx-delay-ns = <2>;
+
 	/* External PHY is in RGMII */
 	phy-mode = "rgmii";
 };
-- 
2.10.2
