From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 30 Jul 2018 13:31:29 +0100
Subject: [PATCH v3 11/19] arm64: dts: allwinner: a64: Orange Pi Win: Add SPI
 flash node
In-Reply-To: <20180730123137.923-1-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
Message-ID: <20180730123137.923-12-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win comes with 2 MB SPI flash, add the node.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 1cb4d3611c6c..3f9c5c8b0264 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -266,6 +266,18 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&spi0 {
+	status = "okay";
+
+	spi-flash at 0 {
+		compatible = "mxicy,mx25l1606e", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		m25p,fast-read;
+		status = "okay";
+	};
+};
+
 /* On debug connector */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.14.4
