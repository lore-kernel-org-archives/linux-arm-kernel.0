From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:05 +0200
Subject: [PATCH V2 03/19] ARM: dts: am57xx: cl-som-am57x: add I2C3 support
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-4-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable I2C3 bus and add appropriate pinmux.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---

  v2:

   * No fuctional changes
   * Refactor patch with respect to the previous changes in I2C4 node structure
   * Reformat subject

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 58156a9..2074fd4 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -52,6 +52,13 @@
 		>;
 	};
 
+	i2c3_pins_default: i2c3_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x36a4, PIN_INPUT| MUX_MODE10)	/* mcasp1_aclkx.i2c3_sda */
+			DRA7XX_CORE_IOPAD(0x36a8, PIN_INPUT| MUX_MODE10)	/* mcasp1_fsx.i2c3_scl */
+		>;
+	};
+
 	i2c4_pins_default: i2c4_pins_default {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x36ac, PIN_INPUT| MUX_MODE10)	/* mcasp1_acl.i2c4_sda */
@@ -73,6 +80,13 @@
 	clock-frequency = <400000>;
 };
 
+&i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins_default>;
+	clock-frequency = <400000>;
+};
+
 &i2c4 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.9.1
