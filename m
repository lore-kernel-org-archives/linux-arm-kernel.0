From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:30 +0200
Subject: [PATCH 07/13] ARM: dts: silk: Add DA9063 PMIC node
In-Reply-To: <cover.1536824376.git.horms+renesas@verge.net.au>
References: <cover.1536824376.git.horms+renesas@verge.net.au>
Message-ID: <bce6d67d035eeaea20dcee12b1362cebde6d9b35.1536824376.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Add DA9063 PMIC node to the I2C bus.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index daec965889d3..6ea60e1faf75 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -405,6 +405,23 @@
 	clock-frequency = <400000>;
 };
 
+&i2c7 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	pmic at 58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
+};
+
 &mmcif0 {
 	pinctrl-0 = <&mmcif0_pins>;
 	pinctrl-names = "default";
-- 
2.11.0
