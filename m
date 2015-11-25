From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:35 +0200
Subject: [PATCH 03/18] ARM: am57xx: cl-som-am57x: dts: add I2C3 support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-4-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable I2C3 bus and add appropriate pinmux.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 773e5389..eb9b81b 100644
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
@@ -265,6 +272,13 @@
 	};
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
