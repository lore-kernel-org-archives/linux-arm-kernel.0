From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 21 Jun 2017 18:01:50 +0800
Subject: [RFC PATCH v3 3/6] ARM/arm64: dts: enable wakeup for cros-ec-spi
 devices
In-Reply-To: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1498039313-24220-4-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to enable wakeup for cros-ec-spi devices unconditionally.
Now we are using the more generic wakeup-source property to enable it.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None

 arch/arm/boot/dts/exynos5420-peach-pit.dts      | 1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts       | 1 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 1 +
 arch/arm/boot/dts/tegra124-nyan.dtsi            | 1 +
 arch/arm/boot/dts/tegra124-venice2.dts          | 1 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts  | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index f9a75bf..a65ec2a 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -950,6 +950,7 @@
 		reg = <0>;
 		spi-max-frequency = <3125000>;
 		google,has-vbc-nvram;
+		wakeup-source;
 
 		controller-data {
 			samsung,spi-feedback-delay = <1>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 953dc86..5209832 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -919,6 +919,7 @@
 		reg = <0>;
 		spi-max-frequency = <3125000>;
 		google,has-vbc-nvram;
+		wakeup-source;
 
 		controller-data {
 			samsung,spi-feedback-delay = <1>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index d752a31..94924df 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -232,6 +232,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&ec_int>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 5cf987b..198fc30 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -318,6 +318,7 @@
 			reg = <0>;
 
 			google,cros-ec-spi-msg-delay = <2000>;
+			wakeup-source;
 
 			i2c-tunnel {
 				compatible = "google,cros-ec-i2c-tunnel";
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 6e59cec..008574d 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -845,6 +845,7 @@
 			reg = <0>;
 
 			google,cros-ec-spi-msg-delay = <2000>;
+			wakeup-source;
 
 			i2c-tunnel {
 				compatible = "google,cros-ec-i2c-tunnel";
diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index 759af96..e0e54a9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -758,6 +758,7 @@
 			reg = <0>;
 
 			google,cros-ec-spi-msg-delay = <2000>;
+			wakeup-source;
 
 			i2c_20: i2c-tunnel {
 				compatible = "google,cros-ec-i2c-tunnel";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index eb50593..409199b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -798,6 +798,7 @@ ap_i2c_audio: &i2c8 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ec_ap_int_l>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
-- 
2.1.4
