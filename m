From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 20:34:21 +0530
Subject: [PATCH v5 1/4] ARM: dts: enable hdmi for exynos5250 based snow board
In-Reply-To: <1400166264-3428-1-git-send-email-rahul.sharma@samsung.com>
References: <1400166264-3428-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1400166264-3428-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable support for HDMI for exynos5250 based Snow board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5250-cros-common.dtsi |    6 +++++-
 arch/arm/boot/dts/exynos5250-snow.dts         |   14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 2c1560d..89ac90f 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -240,7 +240,7 @@
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
 
-		hdmiphy at 38 {
+		hdmiphy: hdmiphy at 38 {
 			compatible = "samsung,exynos4212-hdmiphy";
 			reg = <0x38>;
 		};
@@ -304,6 +304,10 @@
 
 	hdmi {
 		hpd-gpio = <&gpx3 7 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_irq>;
+		phy = <&hdmiphy>;
+		ddc = <&i2c_2>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 1ce1088..7aa5d11 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -37,6 +37,13 @@
 		sd3_bus4: sd3-bus-width4 {
 			samsung,pin-drv = <0>;
 		};
+
+		hdmi_hpd_irq: hdmi-hpd-irq {
+			samsung,pins = "gpx3-7";
+			samsung,pin-function = <0>;
+			samsung,pin-pud = <1>;
+			samsung,pin-drv = <0>;
+		};
 	};
 
 	gpio-keys {
@@ -206,4 +213,11 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	hdmi {
+		hdmi-en-supply = <&tps65090_fet7>;
+		vdd-supply = <&ldo8_reg>;
+		vdd_osc-supply = <&ldo10_reg>;
+		vdd_pll-supply = <&ldo8_reg>;
+	};
 };
-- 
1.7.9.5
