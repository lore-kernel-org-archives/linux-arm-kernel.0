From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 17 Jun 2014 14:40:56 +0100
Subject: [PATCH 1/2] ARM: dts: cubox-i: add support for PWM-driven front panel
 LED
In-Reply-To: <20140617134016.GK23430@n2100.arm.linux.org.uk>
References: <20140617134016.GK23430@n2100.arm.linux.org.uk>
Message-ID: <E1WwtdA-00004r-2V@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The front panel LED on the Cubox-i is driven by one of the iMX6 PWM
channels, and is wired between the PWM output and supply.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 25da82a03110..9202c8d18a30 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -12,6 +12,19 @@
 		pinctrl-0 = <&pinctrl_cubox_i_ir>;
 	};
 
+	pwmleds {
+		compatible = "pwm-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cubox_i_pwm1>;
+
+		front {
+			active-low;
+			label = "imx6:red:front";
+			max-brightness = <248>;
+			pwms = <&pwm1 0 50000>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 
@@ -109,6 +122,10 @@
 			>;
 		};
 
+		pinctrl_cubox_i_pwm1: cubox-i-pwm1-front-led {
+			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b0>;
+		};
+
 		pinctrl_cubox_i_spdif: cubox-i-spdif {
 			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x13091>;
 		};
-- 
1.8.3.1
