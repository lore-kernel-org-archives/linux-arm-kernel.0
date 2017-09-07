From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu,  7 Sep 2017 11:05:25 +0200
Subject: [PATCH 4/9] ARM: dts: TQma53: ESDHC2: use correct IO lines power
 supply
In-Reply-To: <20170907090530.1241-1-jbe@pengutronix.de>
References: <20170907090530.1241-1-jbe@pengutronix.de>
Message-ID: <20170907090530.1241-5-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the devicetree bindings the 'vmmc' power supply is the SD
card's power supply and 'vqmmc' is the IO line's power supply.

The i.MX53's ESDHC2 unit on the 'TQma53' CPU card is dedicated to be used
with an externally connected SD card. The on-board power supply is connected
to the SDHC2 IO lines only. The SD card socket is not part of the CPU card,
so the 'vmmc' info must be part of the baseboard devicetree.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts   | 1 +
 arch/arm/boot/dts/imx53-tqma53.dtsi | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 5a21562a2dc1b..69733c8473d2b 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -193,6 +193,7 @@
 };
 
 &esdhc2 {
+	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index eedeced3c8810..ceba1004038b1 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -33,7 +33,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc2>,
 		    <&pinctrl_esdhc2_cdwp>;
-	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
 	wp-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "disabled";
-- 
2.11.0
