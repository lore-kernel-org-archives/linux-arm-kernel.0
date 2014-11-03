From: marek@goldelico.com (Marek Belisko)
Date: Mon,  3 Nov 2014 22:59:28 +0100
Subject: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
In-Reply-To: <1415051968-4878-1-git-send-email-marek@goldelico.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
Message-ID: <1415051968-4878-5-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gta04 board need for tvout enabled 2 bits in devconf1 register (tvbypass and acbias).
Add single pinmux entry and enable it.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e4d05f0..a456d37 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -118,6 +118,17 @@
 			};
 		};
 	};
+
+	/* pinmux for devconf1 */
+	control_devconf1: pinmux at 480022d8 {
+		compatible = "pinctrl-single";
+		reg = <0x480022d8 4>;	/* single register */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,bit-per-mux;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xfc0bd5>;
+	};
 };
 
 &omap3_pmx_core {
@@ -497,3 +508,14 @@
 		};
 	};
 };
+
+&control_devconf1 {
+	pinctrl-name = "default";
+	pinctrl-0 = < &tv_acbias_pins>;
+
+	tv_acbias_pins: pinmux_tv_acbias_pins {
+		pinctrl-single,bits = <
+			0 0x40800 0x40800
+		>;
+	};
+};
-- 
1.9.1
