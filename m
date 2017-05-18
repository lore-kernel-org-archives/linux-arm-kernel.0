From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 15:16:52 +0800
Subject: [PATCH v6 8/9] arm64: allwinner: a64: enable AXP803 regulators for
 Pine64
In-Reply-To: <20170518071653.36561-1-icenowy@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
Message-ID: <20170518071653.36561-9-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support of AXP803 regulators in the Pine64 device tree, in order to
enable many future functionalities, e.g. Wi-Fi.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v6:
- Rebased on next-20170517.

 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 36001884ed33..40921bacb39c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -118,6 +118,115 @@
 	};
 };
 
+#include "axp803.dtsi"
+
+&reg_aldo1 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vcc-csi";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pl";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pll-avcc";
+};
+
+&reg_dc1sw {
+	regulator-name = "vcc-phy";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-name = "vdd-cpux";
+};
+
+/* DCDC3 is polyphased with DCDC2 */
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_dcdc6 {
+	regulator-always-on;
+	regulator-min-microvolt = <1100000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-hdmi";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-mipi";
+};
+
+&reg_dldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "avdd-csi";
+};
+
+&reg_dldo4 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_eldo1 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "cpvdd";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vdd-1v8-csi";
+};
+
+&reg_fldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vcc-1v2-hsic";
+};
+
+&reg_fldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1100000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
+
 /* On Exp and Euler connectors */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.12.2
