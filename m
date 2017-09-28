From: joel@jms.id.au (Joel Stanley)
Date: Thu, 28 Sep 2017 17:21:45 +0930
Subject: [PATCH 4/8] ARM: dts: aspeed-romulus: Add I2C devices
In-Reply-To: <20170928075149.8154-1-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
Message-ID: <20170928075149.8154-5-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the buses that are in use and the devices that are attached.
Currently that is just the battery backed RTC.

Some of these buses are for hotplugged cards, such as PCIe cards. Others
do not yet have upstream drivers, so there are no devices attached.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 54 ++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 1190fec1b5d0..f79c1d21c47f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -79,3 +79,57 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 };
+
+&i2c2 {
+	status = "okay";
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
+	/* PCIe slot 1 (x8) */
+	status = "enabled";
+};
+
+&i2c7 {
+	/* PCIe slot 2 (x16) */
+	status = "enabled";
+};
+
+&i2c8 {
+	/* PCIe slot 3 (x16) */
+	status = "enabled";
+};
+
+&i2c9 {
+	/* PCIe slot 4 (x16) */
+	status = "enabled";
+};
+
+&i2c10 {
+	/* PCIe slot 5 (x8) */
+	status = "enabled";
+};
+
+&i2c11 {
+	status = "okay";
+
+	rtc at 32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+};
-- 
2.14.1
