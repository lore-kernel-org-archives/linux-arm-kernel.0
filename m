From: marex@denx.de (Marek Vasut)
Date: Thu,  4 May 2017 12:29:49 +0200
Subject: [PATCH 3/4] ARM: dts: socfpga: Drop LED node from VINING FPGA
In-Reply-To: <20170504102950.10667-1-marex@denx.de>
References: <20170504102950.10667-1-marex@denx.de>
Message-ID: <20170504102950.10667-3-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the LED node from VINing FPGA DT because the LED wiring is
different on each mainboard revision. This wiring is therefore
handled in mainboard DT Overlays.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 28 ----------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index 268785ecb82a..9195f11dacdc 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -71,34 +71,6 @@
 		ethernet0 = &gmac1;
 	};
 
-	leds {
-		compatible = "gpio-leds";
-
-		hps_led0 {
-			label = "hps:green:led0";	/* ALIVE_LED_GR */
-			gpios = <&portb 19 0>;	/* HPS_GPIO48 */
-			linux,default-trigger = "heartbeat";
-		};
-
-		hps_led1 {
-			label = "hps:red:led0";		/* ALIVE_LED_RD */
-			gpios = <&portb 24 0>;	/* HPS_GPIO53 */
-			linux,default-trigger = "none";
-		};
-
-		hps_led2 {
-			label = "hps:green:led1";	/* LINK2HOST_LED_GR */
-			gpios = <&portb 25 0>;	/* HPS_GPIO54 */
-			linux,default-trigger = "heartbeat";
-		};
-
-		hps_led3 {
-			label = "hps:red:led1";		/* LINK2HOST_LED_RD */
-			gpios = <&portc 7 0>;	/* HPS_GPIO65 */
-			linux,default-trigger = "none";
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
2.11.0
