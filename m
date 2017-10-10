From: atull@kernel.org (Alan Tull)
Date: Tue, 10 Oct 2017 16:25:38 -0500
Subject: [PATCH 2/2] arm64: dts: stratix10: enable gpio and leds
In-Reply-To: <20171010212538.3331-1-atull@kernel.org>
References: <20171010212538.3331-1-atull@kernel.org>
Message-ID: <20171010212538.3331-2-atull@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable gpio and leds for socdk OOBE daughtercard.

pushbutton PB_SW0 = gpio1.io4
pushbutton PB_SW1 = gpio1.io5
LED HPS_LED0      = gpio1.io20
LED HPS_LED1      = gpio1.io19
LED HPS_LED2      = gpio1.io21

Signed-off-by: Alan Tull <atull@kernel.org>
---
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 46f27ed..a37c461 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -27,6 +27,24 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	memory {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the reg */
@@ -34,6 +52,10 @@
 	};
 };
 
+&gpio1 {
+	status = "okay";
+};
+
 &gmac0 {
 	status = "okay";
 	phy-mode = "rgmii";
-- 
2.7.4
