From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:55 +0200
Subject: [PATCH 20/20] ARM: dts: sun9i: Change node names to remove underscores
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <5763e28fbe7c8e313f29a1ae2e72ddfe7e483f16.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards have had node names with underscores. Remove them in favour of
hyphens in order to reduce the DTC warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 8 ++++----
 arch/arm/boot/dts/sun9i-a80-optimus.dts     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index cb337e08adab..fa09186bc6d7 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -74,7 +74,7 @@
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
 		clock-names = "ext_clock";
@@ -241,20 +241,20 @@
 				regulator-name = "vcc-pm-codec-io1";
 			};
 
-			reg_ldo_io0: ldo_io0 {
+			reg_ldo_io0: ldo-io0 {
 				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pg";
 			};
 
-			reg_ldo_io1: ldo_io1 {
+			reg_ldo_io1: ldo-io1 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-name = "vcc-pa-gmac-2v5";
 			};
 
-			reg_rtc_ldo: rtc_ldo {
+			reg_rtc_ldo: rtc-ldo {
 				regulator-name = "vcc-rtc-vdd1v8-io";
 			};
 
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index ba62e814f4b8..43808f608da2 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -98,7 +98,7 @@
 		gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
 		clock-names = "ext_clock";
@@ -286,20 +286,20 @@
 				regulator-name = "vcc-pm-codec-io1";
 			};
 
-			reg_ldo_io0: ldo_io0 {
+			reg_ldo_io0: ldo-io0 {
 				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pg";
 			};
 
-			reg_ldo_io1: ldo_io1 {
+			reg_ldo_io1: ldo-io1 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-name = "vcc-pa-gmac-2v5";
 			};
 
-			reg_rtc_ldo: rtc_ldo {
+			reg_rtc_ldo: rtc-ldo {
 				regulator-name = "vcc-rtc-vdd1v8-io";
 			};
 
-- 
git-series 0.9.1
