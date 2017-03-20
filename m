From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:53 +0100
Subject: [PATCH 14/31] ARM: dts: r7s72100: Add watchdog timer
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <69ed50de582eff6307fd3fa050fdc505731f0a2d.1489999062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add watchdog timer support for RZ/A1.
For the RZ/A1, the only way to do a reset is to overflow the WDT, so this
is useful even if you don't need the watchdog functionality.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 614ba79a9774..9b12d73e67dc 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -371,6 +371,13 @@
 			<0xe8202000 0x1000>;
 	};
 
+	wdt: watchdog at fcfe0000 {
+		compatible = "renesas,r7s72100-wdt", "renesas,rza-wdt";
+		reg = <0xfcfe0000 0x6>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&p0_clk>;
+	};
+
 	i2c0: i2c at fcfee000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.7.0.rc3.207.g0ac5344
