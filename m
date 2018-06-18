From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Jun 2018 09:45:56 +0200
Subject: [PATCH 5/5] RFC: ARM64: dts: Add Low-Speed Connector to ZCU100
In-Reply-To: <20180618074556.6944-1-linus.walleij@linaro.org>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
Message-ID: <20180618074556.6944-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the low-speed connector to the ZCU100 rev C device
tree (also known as the Ultra96 board).

This is a proof-of-concept only, showing how it is possible
to populate a Secure96 board using the other patches in the
series.

If you comment out or delete the board {} node, you can
populate/depopulate the board from sysfs instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index d62276e0e0a9..fc30497f248d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -110,6 +110,28 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
 	};
+
+	lscon: connector {
+		compatible = "96boards,low-speed-connector";
+		i2c0 = <&i2csw_0>;
+		i2c1 = <&i2csw_1>;
+		spi = <&spi0>;
+		gpios = <&gpio 36 GPIO_ACTIVE_HIGH>, /* GPIO-A */
+		        <&gpio 37 GPIO_ACTIVE_HIGH>, /* GPIO-B */
+			<&gpio 39 GPIO_ACTIVE_HIGH>, /* GPIO-C */
+			<&gpio 40 GPIO_ACTIVE_HIGH>, /* GPIO-D */
+			<&gpio 44 GPIO_ACTIVE_HIGH>, /* GPIO-E */
+			<&gpio 45 GPIO_ACTIVE_HIGH>, /* GPIO-F */
+			<&gpio 78 GPIO_ACTIVE_HIGH>, /* GPIO-G */
+			<&gpio 79 GPIO_ACTIVE_HIGH>, /* GPIO-H */
+			<&gpio 80 GPIO_ACTIVE_HIGH>, /* GPIO-I */
+			<&gpio 81 GPIO_ACTIVE_HIGH>, /* GPIO-J */
+			<&gpio 82 GPIO_ACTIVE_HIGH>, /* GPIO-K */
+			<&gpio 83 GPIO_ACTIVE_HIGH>; /* GPIO-L */
+		board {
+			compatible = "96boards,secure96";
+		};
+	};
 };
 
 &dcc {
@@ -134,8 +156,9 @@
 			  "USB1_DIR", "USB1_DATA2", "USB1_NXT", "USB1_DATA0", "USB1_DATA1",
 			  "USB1_STP", "USB1_DATA3", "USB1_DATA4", "USB1_DATA5", "USB1_DATA6",
 			  "USB_DATA7", "WLAN_IRQ", "PMIC_IRQ", /* MIO end and EMIO start */
-			  "", "",
-			  "", "", "", "", "", "", "", "", "", "",
+			  "GPIO-G", "GPIO-H",
+			  "GPIO-I", "GPIO-J", "GPIO-K", "GPIO-L",
+			  "", "", "", "", "", "",
 			  "", "", "", "", "", "", "", "", "", "",
 			  "", "", "", "", "", "", "", "", "", "",
 			  "", "", "", "", "", "", "", "", "", "",
-- 
2.17.0
