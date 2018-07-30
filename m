From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 30 Jul 2018 13:17:26 +0200
Subject: [PATCH] ARM: shmobile: gose: Add DA9210 node for CPU DVFS
Message-ID: <20180730111726.5526-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DA9210 DVFS node to the I2C bus and link it to CPU0 for DVFS.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
---
 arch/arm/boot/dts/r8a7793-gose.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 6b2f3a4fd13d..f51601af89a2 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -596,6 +596,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+};
+
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
@@ -725,6 +729,18 @@
 			compatible = "dlg,da9063-watchdog";
 		};
 	};
+
+	vdd_dvfs: regulator at 68 {
+		compatible = "dlg,da9210";
+		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &i2c4 {
-- 
2.16.2
