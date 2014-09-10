From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 12:19:48 +0200
Subject: [PATCH v3 4/7] ARM: dts: Add thermistor dts fragment used by exynos
 based Peach boards
In-Reply-To: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410344391-5675-5-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

This patch creates a thermistor fragment carrying the NTC Thermistor
nodes as children of the IIO based ADC.

This fragment is included in exynos5420-peach-pit.dts and
exynos5800-peach-pi.dts.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/cros-adc-thermistors.dtsi | 44 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts  |  6 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts   |  6 ++++
 3 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/cros-adc-thermistors.dtsi

diff --git a/arch/arm/boot/dts/cros-adc-thermistors.dtsi b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
new file mode 100644
index 0000000..acd4fe1
--- /dev/null
+++ b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
@@ -0,0 +1,44 @@
+/*
+ * Thermistor dts fragment for devices that use Thermistors as
+ * children of the IIO based ADC.
+ *
+ * Currently, used by Exynos5420 based Peach PIT and
+ * Exynos5800 based Peach PI.
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+&adc {
+	ncp15wb473 at 3 {
+		compatible = "murata,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 3>;
+	};
+	ncp15wb473 at 4 {
+		compatible = "murata,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 4>;
+	};
+	ncp15wb473 at 5 {
+		compatible = "murata,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 5>;
+	};
+	ncp15wb473 at 6 {
+		compatible = "murata,ncp15wb473";
+		pullup-uv = <1800000>;
+		pullup-ohm = <47000>;
+		pulldown-ohm = <0>;
+		io-channels = <&adc 6>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 88f1620..07115b7 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -103,6 +103,11 @@
 	};
 };
 
+&adc {
+	status = "okay";
+	vdd-supply = <&ldo9_reg>;
+};
+
 &dp {
 	status = "okay";
 	pinctrl-names = "default";
@@ -813,3 +818,4 @@
 };
 
 #include "cros-ec-keyboard.dtsi"
+#include "cros-adc-thermistors.dtsi"
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7c2095b..1c128e1 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -101,6 +101,11 @@
 	};
 };
 
+&adc {
+	status = "okay";
+	vdd-supply = <&ldo9_reg>;
+};
+
 &dp {
 	status = "okay";
 	pinctrl-names = "default";
@@ -811,3 +816,4 @@
 };
 
 #include "cros-ec-keyboard.dtsi"
+#include "cros-adc-thermistors.dtsi"
-- 
2.1.0
