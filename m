From: manu@freebsd.org (Emmanuel Vadot)
Date: Thu, 17 May 2018 12:34:35 +0200
Subject: [PATCH] ARM64: dts: sun50i: h5: Add spi flash node for OrangePi PC2
Message-ID: <20180517103435.92874-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OrangePi PC2 have an mx25l1606e spi flash.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 98862c7c7258..0b870e4b4fad 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -207,6 +207,18 @@
 	status = "okay";
 };
 
+&spi0  {
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mx25l1606e", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.17.0
