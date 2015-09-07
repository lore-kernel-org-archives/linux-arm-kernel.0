From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon,  7 Sep 2015 18:24:18 +0200
Subject: [PATCH] ARM: dts: omap3-igep: Move eth IRQ pinmux to IGEPv2 common
 dtsi
Message-ID: <1441643058-8641-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the IGEPv2 boards have a LAN9221i chip connected to the GPMC
so the pinmux configuration for the GPIO connected to the IRQ line
of the LAN chip should not be defined in the IGEP common dtsi but
in the one common to the IGEPv2 boards.

While there, use the OMAP3_CORE1_IOPAD() macro for the padconf reg.

Suggested-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/omap3-igep.dtsi            | 6 ------
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index d5e5cd449b16..2230e1c03320 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -78,12 +78,6 @@
 		>;
 	};
 
-	smsc9221_pins: pinmux_smsc9221_pins {
-		pinctrl-single,pins = <
-			0x1a2 (PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
-		>;
-	};
-
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
 			0x18a (PIN_INPUT | MUX_MODE0)   /* i2c1_scl.i2c1_scl */
diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
index e458c2185e3c..5ad688c57a00 100644
--- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
+++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
@@ -156,6 +156,12 @@
 			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)	/* uart2_rx.uart2_rx */
 		>;
 	};
+
+	smsc9221_pins: pinmux_smsc9221_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT | MUX_MODE4)	/* mcspi1_cs2.gpio_176 */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
-- 
2.4.3
