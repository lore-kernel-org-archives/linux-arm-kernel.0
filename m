From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 16 Aug 2017 10:16:30 +0100
Subject: [PATCH v2] ARM: dts: iwg20d-q7: Add RTC support
Message-ID: <1502874990-12006-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Define the iWave RainboW-G20D-Qseven board dependent part of the
RTC device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[chris: corrected bq32000 compatible string]
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
v1 -> v2
Added ti to bq32000 compatible string - Thanks Geert

 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 081af01..2c81ea7 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -31,6 +31,11 @@
 		groups = "avb_mdio", "avb_gmii";
 		function = "avb";
 	};
+
+	i2c2_pins: i2c2 {
+		groups = "i2c2";
+		function = "i2c2";
+	};
 };
 
 &scif0 {
@@ -54,3 +59,16 @@
 		micrel,led-mode = <1>;
 	};
 };
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	rtc at 68 {
+		compatible = "ti,bq32000";
+		reg = <0x68>;
+	};
+};
-- 
1.9.1
