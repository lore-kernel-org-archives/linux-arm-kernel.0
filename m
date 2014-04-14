From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Apr 2014 17:37:25 +0200
Subject: [PATCH 03/10] ARM: dts: pfla02: Add GPIO LEDs
In-Reply-To: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
References: <1397489852-1669-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1397489852-1669-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the red and green GPIO LEDs on Phytec phyFLEX i.MX6 modules.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 8ab2c44..7138937 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -40,6 +40,20 @@
 			gpio = <&gpio1 0 0>;
 		};
 	};
+
+	gpio_leds: leds {
+		compatible = "gpio-leds";
+
+		green {
+			label = "phyflex:green";
+			gpios = <&gpio1 30 0>;
+		};
+
+		red {
+			label = "phyflex:red";
+			gpios = <&gpio2 31 0>;
+		};
+	};
 };
 
 &ecspi3 {
@@ -156,6 +170,8 @@
 				MX6QDL_PAD_EIM_D23__GPIO3_IO23 0x80000000
 				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
 				MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000 /* PMIC interrupt */
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x80000000 /* Green LED */
+				MX6QDL_PAD_EIM_EB3__GPIO2_IO31 0x80000000 /* Red LED */
 			>;
 		};
 
-- 
1.9.1
