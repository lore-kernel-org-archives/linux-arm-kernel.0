From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 16 Feb 2014 10:40:56 +0100
Subject: [PATCH 3/5] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
In-Reply-To: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392543658-5030-4-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d4b9bba..b3f75d7 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -108,10 +108,29 @@
 	clock-frequency = <20000000>;
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom at 50 {
+		compatible = "renesas,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
 &pfc {
 	pinctrl-0 = <&scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
+	i2c2_pins: i2c {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
-- 
1.8.5.1
