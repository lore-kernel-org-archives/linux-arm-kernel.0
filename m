From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Sun, 20 Apr 2014 16:54:02 +0530
Subject: [PATCH 5/7] ARM: dts: enable hdmi for exynos5250 based snow board
In-Reply-To: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
References: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1397993044-14564-6-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable support for HDMI for exynos5250 based Snow board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5250-cros-common.dtsi |   13 ++++++++++++-
 arch/arm/boot/dts/exynos5250-snow.dts         |    7 +++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 2c1560d..50c39a3 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -34,6 +34,13 @@
 			samsung,pin-pud = <0>;
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
 
 	i2c at 12C60000 {
@@ -240,7 +247,7 @@
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
 
-		hdmiphy at 38 {
+		hdmiphy: hdmiphy at 38 {
 			compatible = "samsung,exynos4212-hdmiphy";
 			reg = <0x38>;
 		};
@@ -304,6 +311,10 @@
 
 	hdmi {
 		hpd-gpio = <&gpx3 7 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_irq>;
+		phy = <&hdmiphy>;
+		ddc = <&i2c_2>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 52ae335..586cd38 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -343,4 +343,11 @@
 			pinctrl-0 = <&ptn3460_gpios>;
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
