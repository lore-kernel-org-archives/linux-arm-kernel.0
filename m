From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:23 +0200
Subject: [Patch v2][ 25/37] arm/dts: imx51.dtsi: Add some pinmux pins.
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-26-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx51.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index f4dcff3..48fa41b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -621,6 +621,15 @@
 		};
 	};
 
+	i2c1 {
+		pinctrl_i2c1_1: i2c1grp-1 {
+			fsl,pins = <
+				MX51_PAD_SD2_CMD__I2C1_SCL 0x400001ed
+				MX51_PAD_SD2_CLK__I2C1_SDA 0x400001ed
+			>;
+		};
+	};
+
 	i2c2 {
 		pinctrl_i2c2_1: i2c2grp-1 {
 			fsl,pins = <
@@ -801,6 +810,13 @@
 				MX51_PAD_UART3_TXD__UART3_TXD 0x1c5
 			>;
 		};
+
+		pinctrl_uart3_rtscts_2: uart3rtscts-2 {
+			fsl,pins = <
+				MX51_PAD_KEY_COL4__UART3_RTS 0x1c5
+				MX51_PAD_KEY_COL5__UART3_CTS 0x1c5
+			>;
+		};
 	};
 
 	usbh1 {
-- 
1.7.9.5
