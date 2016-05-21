From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 May 2016 15:40:52 +0200
Subject: [PATCH v2 3/5] ARM: dts: rockchip: move rk3288 io-domain nodes to
 the grf
In-Reply-To: <1459432126-6395-4-git-send-email-heiko@sntech.de>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
 <1459432126-6395-4-git-send-email-heiko@sntech.de>
Message-ID: <3043390.x2mOUff8Ni@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 31. M?rz 2016, 15:48:44 schrieb Heiko Stuebner:
> io-voltage control is actually part of the grf, so move the node under the
> newly available grf simple-mfd.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 4.8, but adapted slightly to have the core io-domain nodes centrally in the rk3288.dtsi:

----- 8< -----
From: Heiko Stuebner <heiko@sntech.de>
Date: Sat, 21 May 2016 01:36:17 +0200
Subject: [PATCH v2.1 3/5] ARM: dts: rockchip: move rk3288 io-domain nodes to the grf

io-voltage control is actually part of the grf, so move the node under the
newly available grf simple-mfd.

To minimize duplicate code, the core node and compatible property
gets placed in the core rk3288.dtsi while the individual boards
now only need to enable it and add the necessary supply properties.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi   | 31 +++++++++++++++----------------
 arch/arm/boot/dts/rk3288-miqi.dts       | 26 +++++++++++++-------------
 arch/arm/boot/dts/rk3288-popmetal.dts   | 31 +++++++++++++++----------------
 arch/arm/boot/dts/rk3288-rock2-som.dtsi | 31 +++++++++++++++----------------
 arch/arm/boot/dts/rk3288-veyron.dtsi    | 25 ++++++++++++-------------
 arch/arm/boot/dts/rk3288.dtsi           |  5 +++++
 6 files changed, 75 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index d6cf9ad..114c90fb 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -64,22 +64,6 @@
 		clock-output-names = "ext_gmac";
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		audio-supply = <&vcca_33>;
-		bb-supply = <&vcc_io>;
-		dvp-supply = <&dovdd_1v8>;
-		flash0-supply = <&vcc_flash>;
-		flash1-supply = <&vcc_lan>;
-		gpio30-supply = <&vcc_io>;
-		gpio1830-supply = <&vcc_io>;
-		lcdc-supply = <&vcc_io>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vccio_wl>;
-	};
-
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		pinctrl-names = "default";
@@ -397,6 +381,21 @@
 	status = "okay";
 };
 
+&io_domains {
+	status = "okay";
+
+	audio-supply = <&vcca_33>;
+	bb-supply = <&vcc_io>;
+	dvp-supply = <&dovdd_1v8>;
+	flash0-supply = <&vcc_flash>;
+	flash1-supply = <&vcc_lan>;
+	gpio30-supply = <&vcc_io>;
+	gpio1830-supply = <&vcc_io>;
+	lcdc-supply = <&vcc_io>;
+	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vccio_wl>;
+};
+
 &pinctrl {
 	pcfg_output_high: pcfg-output-high {
 		output-high;
diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index 8643103..2448842 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -64,19 +64,6 @@
 		clock-output-names = "ext_gmac";
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-
-		audio-supply = <&vcca_33>;
-		flash0-supply = <&vcc_flash>;
-		flash1-supply = <&vcc_lan>;
-		gpio30-supply = <&vcc_io>;
-		gpio1830-supply = <&vcc_io>;
-		lcdc-supply = <&vcc_io>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vcc_18>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
@@ -321,6 +308,19 @@
 	status = "okay";
 };
 
+&io_domains {
+	status = "okay";
+
+	audio-supply = <&vcca_33>;
+	flash0-supply = <&vcc_flash>;
+	flash1-supply = <&vcc_lan>;
+	gpio30-supply = <&vcc_io>;
+	gpio1830-supply = <&vcc_io>;
+	lcdc-supply = <&vcc_io>;
+	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vcc_18>;
+};
+
 &pinctrl {
 	pcfg_output_high: pcfg-output-high {
 		output-high;
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index 720717b..dda8d25 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -77,22 +77,6 @@
 		};
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		audio-supply = <&vcca_33>;
-		bb-supply = <&vcc_io>;
-		dvp-supply = <&vcc18_dvp>;
-		flash0-supply = <&vcc_flash>;
-		flash1-supply = <&vcc_lan>;
-		gpio30-supply = <&vcc_io>;
-		gpio1830-supply = <&vcc_io>;
-		lcdc-supply = <&vcc_io>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vccio_wl>;
-	};
-
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
@@ -437,6 +421,21 @@
 	status = "okay";
 };
 
+&io_domains {
+	status = "okay";
+
+	audio-supply = <&vcca_33>;
+	bb-supply = <&vcc_io>;
+	dvp-supply = <&vcc18_dvp>;
+	flash0-supply = <&vcc_flash>;
+	flash1-supply = <&vcc_lan>;
+	gpio30-supply = <&vcc_io>;
+	gpio1830-supply = <&vcc_io>;
+	lcdc-supply = <&vcc_io>;
+	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vccio_wl>;
+};
+
 &pinctrl {
 	ak8963 {
 		comp_int: comp-int {
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index e1ee9f9..bb1f01e 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -61,22 +61,6 @@
 		clock-output-names = "ext_gmac";
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		audio-supply = <&vcc_io>;
-		bb-supply = <&vcc_io>;
-		dvp-supply = <&vcc_18>;
-		flash0-supply = <&vcc_flash>;
-		flash1-supply = <&vccio_pmu>;
-		gpio30-supply = <&vccio_pmu>;
-		gpio1830 = <&vcc_io>;
-		lcdc-supply = <&vcc_io>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vcc_18>;
-	};
-
 	vcc_flash: flash-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -259,6 +243,21 @@
 	};
 };
 
+&io_domains {
+	status = "okay";
+
+	audio-supply = <&vcc_io>;
+	bb-supply = <&vcc_io>;
+	dvp-supply = <&vcc_18>;
+	flash0-supply = <&vcc_flash>;
+	flash1-supply = <&vccio_pmu>;
+	gpio30-supply = <&vccio_pmu>;
+	gpio1830 = <&vcc_io>;
+	lcdc-supply = <&vcc_io>;
+	sdcard-supply = <&vccio_sd>;
+	wifi-supply = <&vcc_18>;
+};
+
 &pinctrl {
 	pcfg_output_high: pcfg-output-high {
 		output-high;
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 5e4c690..3dd2cca 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -83,19 +83,6 @@
 		reset-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		bb-supply = <&vcc33_io>;
-		dvp-supply = <&vcc_18>;
-		flash0-supply = <&vcc18_flashio>;
-		gpio1830-supply = <&vcc33_io>;
-		gpio30-supply = <&vcc33_io>;
-		lcdc-supply = <&vcc33_lcd>;
-		wifi-supply = <&vcc18_wl>;
-	};
-
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rk808 RK808_CLKOUT1>;
@@ -355,6 +342,18 @@
 	i2c-scl-rising-time-ns = <1000>;
 };
 
+&io_domains {
+	status = "okay";
+
+	bb-supply = <&vcc33_io>;
+	dvp-supply = <&vcc_18>;
+	flash0-supply = <&vcc18_flashio>;
+	gpio1830-supply = <&vcc33_io>;
+	gpio30-supply = <&vcc33_io>;
+	lcdc-supply = <&vcc33_lcd>;
+	wifi-supply = <&vcc18_wl>;
+};
+
 &pwm1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 3b44ef3..7fa932f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -826,6 +826,11 @@
 			#phy-cells = <0>;
 			status = "disabled";
 		};
+
+		io_domains: io-domains {
+			compatible = "rockchip,rk3288-io-voltage-domain";
+			status = "disabled";
+		};
 	};
 
 	wdt: watchdog at ff800000 {
-- 
2.6.4

----- 8< -----
