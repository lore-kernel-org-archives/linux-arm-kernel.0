From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Dec 2015 18:30:27 +0100
Subject: [PATCH v3 02/10] ARM: dts: Exynos5420/5800: add cluster regulator
 supply properties
In-Reply-To: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449250235-9613-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cluster regulator supply properties as a preparation to
adding generic arm_big_little_dt cpufreq driver support for
Exynos5420 and Exynos5800 based boards.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   | 8 ++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts      | 8 ++++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts       | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts      | 8 ++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts       | 8 ++++++++
 7 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 4ecef69..24b8a35 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -52,6 +52,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 35cfb07..2b74230 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -676,6 +676,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_2 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index ac35aef..9e2dc5f 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -423,3 +423,11 @@
 &usbdrd_phy1 {
 	vbus-supply = <&usb301_vbus_reg>;
 };
+
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index 2ae1cf4..6f1de7c 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -54,6 +54,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 432406d..6b64122 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -53,6 +53,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
 &i2c_0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 2faf886..516a40f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -32,6 +32,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7b018e4..34aaaacd 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -638,6 +638,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_2 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
-- 
1.9.1
