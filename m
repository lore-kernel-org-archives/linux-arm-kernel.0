From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 31 Jan 2018 08:56:38 +0200
Subject: [PATCH v2 2/2] arm64: dts: marvell: mcbin: enable uart headers
In-Reply-To: <03f1bec6e11c9f6fb9d5520c745eafca28597801.1517381798.git.baruch@tkos.co.il>
References: <03f1bec6e11c9f6fb9d5520c745eafca28597801.1517381798.git.baruch@tkos.co.il>
Message-ID: <b4dc178abd765426e0d0e3aa3be9d8ac7d1301d6.1517381798.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description of the J25 and J27 UART headers of the Macchiatobin. They use
uart peripherals that the CP0 (J25) and CP1 (J27) provide.

Even though J25 and J27 are labeled as UART header, the pins on these headers
can be muxed for other purposes. But the UART functionality is useful when the
board is mounted in an ATX style enclosure, since the console UART is not
accessible through the microUSB at CON9.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
  Add comments to indicate the headers board labels (Thomas)
  Explain in the commit log why we want the UART functionality (RMK)
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 626e9d0462c3..122d2257ebc4 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -163,6 +163,13 @@
 	};
 };
 
+/* J25 UART header */
+&cp0_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_uart1_pins>;
+	status = "okay";
+};
+
 &cp0_mdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cp0_ge_mdio_pins>;
@@ -195,6 +202,10 @@
 		marvell,pins = "mpp37", "mpp38";
 		marvell,function = "i2c0";
 	};
+	cp0_uart1_pins: uart1-pins {
+		marvell,pins = "mpp40", "mpp41";
+		marvell,function = "uart1";
+	};
 	cp0_xhci_vbus_pins: xhci0-vbus-pins {
 		marvell,pins = "mpp47";
 		marvell,function = "gpio";
@@ -290,6 +301,17 @@
 		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
 		marvell,function = "spi1";
 	};
+	cp1_uart0_pins: uart0-pins {
+		marvell,pins = "mpp6", "mpp7";
+		marvell,function = "uart0";
+	};
+};
+
+/* J27 UART header */
+&cp1_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_uart0_pins>;
+	status = "okay";
 };
 
 &cp1_sata0 {
-- 
2.15.1
