From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 14:04:24 +0100
Subject: [PATCH  1/2] ARM: dts: iwg20d-q7: Add RTC support
In-Reply-To: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
References: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502197465-61546-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the iWave RainboW-G20D-Qseven board dependent part of the
RTC device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 081af01..b3a1efa 100644
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
+		compatible = "bq32000";
+		reg = <0x68>;
+	};
+};
-- 
1.9.1
