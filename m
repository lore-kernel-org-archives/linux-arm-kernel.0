From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:12 +0200
Subject: [PATCH 17/29] arm64: dts: renesas: condor: add I2C0 support
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <45fde0d498dc77e5fc221960843fa377e0c70822.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Condor board dependent part of the I2C0 device node.

The I2C0 bus is populated by 2 ON Semiconductor PCA9654 I/O expanders
and Analog Devices  ADV7511W HDMI transmitter (but we're only describing
the former chips now).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index 0b93a7d76585..cc3ee25f4e2d 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -80,6 +80,28 @@
 	clock-frequency = <32768>;
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	io_expander0: gpio at 20 {
+		compatible = "onnn,pca9654";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	io_expander1: gpio at 21 {
+		compatible = "onnn,pca9654";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &mmc0 {
 	pinctrl-0 = <&mmc_pins>;
 	pinctrl-1 = <&mmc_pins_uhs>;
@@ -104,6 +126,11 @@
 		function = "canfd0";
 	};
 
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
 	mmc_pins: mmc {
 		groups = "mmc_data8", "mmc_ctrl", "mmc_ds";
 		function = "mmc";
-- 
2.11.0
