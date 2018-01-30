From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 30 Jan 2018 10:01:26 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: mcbin: enable uart headers
In-Reply-To: <1ebd25aace6c9ab93abe7fb6e42ef9e275eee321.1517299286.git.baruch@tkos.co.il>
References: <1ebd25aace6c9ab93abe7fb6e42ef9e275eee321.1517299286.git.baruch@tkos.co.il>
Message-ID: <97a7416bb0eb19c9d32e41984e292a869ff14230.1517299286.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description of the J25 and J27 UART headers of the Macchiatobin. They use
uart peripherals that the CP0 (J25) and CP1 (J27) provides.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 626e9d0462c3..3ce15b740bb0 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -163,6 +163,12 @@
 	};
 };
 
+&cp0_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_uart1_pins>;
+	status = "okay";
+};
+
 &cp0_mdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cp0_ge_mdio_pins>;
@@ -195,6 +201,10 @@
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
@@ -290,6 +300,16 @@
 		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
 		marvell,function = "spi1";
 	};
+	cp1_uart0_pins: uart0-pins {
+		marvell,pins = "mpp6", "mpp7";
+		marvell,function = "uart0";
+	};
+};
+
+&cp1_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_uart0_pins>;
+	status = "okay";
 };
 
 &cp1_sata0 {
-- 
2.15.1
