From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Dec 2015 11:52:40 +0900
Subject: [PATCH/RFC 03/19] ARM: shmobile: gose: add i2c2 bus to device tree
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1449802376-11301-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Activate i2c2 bus in r8a7793/gose device tree.

Based on similar work for the r8a7791/koelsch by Wolfram Sang.

Cc: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 3e3122490650..9a71ff6d4474 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -38,6 +38,11 @@
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
@@ -135,3 +140,17 @@
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
+		compatible = "renesas,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
-- 
2.1.4
