From: joel@jms.id.au (Joel Stanley)
Date: Thu, 28 Sep 2017 17:21:47 +0930
Subject: [PATCH 6/8] ARM: dts: aspeed-ast2500: Add I2C devices
In-Reply-To: <20170928075149.8154-1-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
Message-ID: <20170928075149.8154-7-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the buses that are in use and the devices that are attached.
Currently that includes temperature measurement and EEPROM.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 7c90dac99822..dc7d73b02b76 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -59,3 +59,22 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
 };
+
+&i2c3 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	lm75 at 4d {
+		compatible = "national,lm75";
+		reg = <0x4d>;
+	};
+};
-- 
2.14.1
