From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon,  4 Dec 2017 10:23:07 +0530
Subject: [PATCH v2 2/2] arm64: allwinner: a64-sopine: Fix to use dcdc1
 regulator instead of vcc3v3
In-Reply-To: <1512363187-8353-1-git-send-email-jagan@amarulasolutions.com>
References: <1512363187-8353-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1512363187-8353-2-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since current tree support AXP803 regulators,
replace fixed regulator vcc3v3 with AXP803 dcdc1 regulator where ever
it need to replace.

Tested mmc0 on sopine baseboard.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Commit message edited as fix since it has issue with sdcard detect.

 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi          | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index a053a6a..abe179d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -96,7 +96,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	vqmmc-supply = <&reg_vcc1v8>;
 	bus-width = <8>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index a5da18a..43418bd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -45,19 +45,10 @@
 
 #include "sun50i-a64.dtsi"
 
-/ {
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	non-removable;
 	disable-wp;
 	bus-width = <4>;
-- 
2.7.4
