From: joel@jms.id.au (Joel Stanley)
Date: Thu, 28 Sep 2017 17:21:46 +0930
Subject: [PATCH 5/8] ARM: dts: aspeed-palmetto: Add I2C devices
In-Reply-To: <20170928075149.8154-1-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
Message-ID: <20170928075149.8154-6-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the buses that are in use and the devices that are attached.
Currently that includes the battery backed RTC, temperature measurement
and EEPROM.

Some of these buses are for hotplugged cards, such as PCIe cards.
Others do not yet have upstream drivers, so there are no devices
attached.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index 112551766275..e387c80b7f4f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -61,3 +61,51 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 };
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+
+	rtc at 68 {
+		compatible = "dallas,ds3231";
+		reg = <0x68>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	tmp423 at 4c {
+		compatible = "ti,tmp423";
+		reg = <0x4c>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
-- 
2.14.1
