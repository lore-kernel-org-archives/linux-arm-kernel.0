From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 10 Dec 2015 17:58:43 +0100
Subject: [PATCH v5 1/7] ARM: dts: Exynos542x/5800: add cluster regulator supply
 properties
In-Reply-To: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449766729-435-2-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cluster regulator supply properties as a preparation to
adding generic cpufreq-dt driver support for Exynos542x and
Exynos5800 based boards.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 8 ++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 8 ++++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 8 ++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 8 ++++++++
 5 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 4ecef69..4229641 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -52,6 +52,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-supply = <&buck6_reg>;
+};
+
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 35cfb07..df071b33 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -143,6 +143,14 @@
 	vdd-supply = <&ldo9_reg>;
 };
 
+&cpu0 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-supply = <&buck6_reg>;
+};
+
 &dp {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index ac35aef..124a9ba 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -89,6 +89,14 @@
 
 };
 
+&cpu0 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-supply = <&buck6_reg>;
+};
+
 &dp {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hpd>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 9134217..1bd507b 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -67,6 +67,14 @@
 			<19200000>;
 };
 
+&cpu0 {
+	cpu-supply = <&buck6_reg>;
+};
+
+&cpu4 {
+	cpu-supply = <&buck2_reg>;
+};
+
 &hdmi {
 	status = "okay";
 	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7b018e4..2f6d8ac 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -137,6 +137,14 @@
 	vdd-supply = <&ldo9_reg>;
 };
 
+&cpu0 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-supply = <&buck6_reg>;
+};
+
 &dp {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.9.1
