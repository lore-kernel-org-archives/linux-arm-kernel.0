From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 30 Jul 2018 13:18:17 +0200
Subject: [PATCH] ARM: shmobile: silk: Add DA9063 PMIC node
Message-ID: <20180730111817.5636-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DA9063 PMIC node to the I2C bus.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
---
 arch/arm/boot/dts/r8a7794-silk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index daec965889d3..bf7e8ffd1e69 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -403,6 +403,18 @@
 	pinctrl-names = "i2c-hdmi";
 
 	clock-frequency = <400000>;
+
+	pmic at 5a {
+		compatible = "dlg,da9063";
+		reg = <0x5a>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
 };
 
 &mmcif0 {
-- 
2.16.2
