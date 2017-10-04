From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 17:19:14 +1030
Subject: [PATCH v2 6/9] ARM: dts: aspeed-ast2500: Add I2C devices
In-Reply-To: <20171004064917.2498-1-joel@jms.id.au>
References: <20171004064917.2498-1-joel@jms.id.au>
Message-ID: <20171004064917.2498-7-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the buses that are in use and the devices that are attached.
Currently that includes temperature measurement and EEPROM.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
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
