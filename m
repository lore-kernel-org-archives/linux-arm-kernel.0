From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Sat, 20 May 2017 00:35:50 +0300
Subject: [PATCH 2/2] ARM: dts: orange-pi-zero: enable SPI NOR
In-Reply-To: <20170519213550.8434-1-geomatsi@gmail.com>
References: <20170519213550.8434-1-geomatsi@gmail.com>
Message-ID: <20170519213550.8434-3-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SPI NOR on orange-pi-zero board.

For more information see:
- http://linux-sunxi.org/Orange_Pi_Zero#SPI_NOR_flash

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 34e4a5a80136..fe39e96cee65 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -177,3 +177,19 @@
 	status = "okay";
 	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 };
+
+&spi0 {
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+
+		partition at 00000000 {
+			reg = <0x00000000 0x200000>;	/* 2Mb */
+		};
+	};
+};
-- 
2.11.0
