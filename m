From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 21 May 2018 13:54:26 +0200
Subject: [PATCH v2] ARM64: dts: sun50i: h5: Add spi flash node for OrangePi PC2
Message-ID: <20180521115426.92115-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OrangePi PC2 have an mx25l1606e spi flash.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
Changes in v2:
 - Only use the compatible 'jedec,spi-nor' since the device answer to
 the jedec command 0x9F

 arch/arm64//boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 98862c7c7258..3e0d5a9c096d 100644
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
+		compatible = "jedec,spi-nor";
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
