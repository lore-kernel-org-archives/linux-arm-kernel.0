From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu,  9 Jan 2014 17:47:57 +0100
Subject: [PATCH 03/18] ARM: dts: omap3-tobi: Add missing pinctrl
In-Reply-To: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1389286092-27087-4-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing pinctrl entries:
- i2c3

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-tobi.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index 9fe10ca..d39fe57 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -38,6 +38,15 @@
 	};
 };
 
+&omap3_pmx_core {
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl.i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
+		>;
+	};
+};
+
 &gpmc {
 	ranges = <5 0 0x2c000000 0x1000000>;	/* CS5 */
 
@@ -75,6 +84,8 @@
 };
 
 &i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
 	clock-frequency = <100000>;
 };
 
-- 
1.8.1.2
