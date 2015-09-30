From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 30 Sep 2015 21:17:49 +0200
Subject: [PATCH 4/5] ARM: dts: rockchip: fixup firefly mmc supplies
In-Reply-To: <1443640670-21104-1-git-send-email-heiko@sntech.de>
References: <1443640670-21104-1-git-send-email-heiko@sntech.de>
Message-ID: <1443640670-21104-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some incorrect references to mmc regulators.
vccio_wl for example is the io-voltage supply not the core supply
of the wifi module itself, which is vbat_wl instead.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index d7a6ff8..a7b1972 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -96,7 +96,7 @@
 		};
 	};
 
-	vcc_sys: vsys-regulator {
+	vbat_wl: vcc_sys: vsys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-min-microvolt = <5000000>;
@@ -329,7 +329,7 @@
 				regulator-always-on;
 			};
 
-			vcc_18: REG11 {
+			vccio_wl: vcc_18: REG11 {
 				regulator-name = "vcc_18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -449,7 +449,8 @@
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
-	vmmc-supply = <&vcc_18>;
+	vmmc-supply = <&vbat_wl>;
+	vqmmc-supply = <&vccio_wl>;
 	status = "okay";
 };
 
@@ -463,6 +464,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
 	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
 	status = "okay";
 };
 
-- 
2.5.3
