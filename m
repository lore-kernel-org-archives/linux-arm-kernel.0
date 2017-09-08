From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 13:21:42 -0500
Subject: [PATCH v2 2/2] ARM: dts: keystone-k2g-evm: Add I2C EEPROM DT entry
In-Reply-To: <20170908182142.5274-1-fcooper@ti.com>
References: <20170908182142.5274-1-fcooper@ti.com>
Message-ID: <20170908182142.5274-3-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

K2G EVM has an onboard I2C EEPROM connected to I2C0. This patch adds
the necessary DT entry for the AT24CM01 EEPROM.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index f462f10..a6ad5fc 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -81,6 +81,14 @@
 			K2G_CORE_IOPAD(0x1110) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_cmd.mmc1_cmd */
 		>;
 	};
+
+	i2c0_pins: pinmux_i2c0_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x137c) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			K2G_CORE_IOPAD(0x1380) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+		>;
+	};
+
 };
 
 &uart0 {
@@ -112,3 +120,14 @@
 	memory-region = <&dsp_common_memory>;
 	status = "okay";
 };
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c1024";
+		reg = <0x50>;
+	};
+};
-- 
2.9.4.dirty
