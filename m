From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  5 Jan 2016 09:16:20 +1100
Subject: [PATCH v2] ARM: shmobile: gose: add i2c2 bus to device tree
Message-ID: <1451945780-17558-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Activate i2c2 bus in r8a7793/gose device tree.

Based on similar work for the r8a7791/koelsch by Wolfram Sang.

Cc: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Update eprom compat strings to "renesas,r1ex24002", "atmel,24c02".
  The former needs to be documented once the desired mechanism
  for documenting eprom compat strings has been confirmed
  with the maintainer.
---
 arch/arm/boot/dts/r8a7793-gose.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 90b587c3c736..987ed03b1e02 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -136,6 +136,11 @@
 };
 
 &pfc {
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
@@ -234,3 +239,17 @@
 		};
 	};
 };
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <100000>;
+
+	eeprom at 50 {
+		compatible = "renesas,r1ex24002", "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
-- 
2.1.4
