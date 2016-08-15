From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:29 +0200
Subject: [PATCH 10/26] ARM: dts: blanche: add CAN0 support
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <38584104eafb6ed40ca06c8421dcc369c9015c1d.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Blanche board dependent part of the CAN0 device node along with
the CAN_CLK crystal.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792-blanche.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index 4777a609ff81..eeffba870211 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -60,6 +60,10 @@
 	clock-frequency = <20000000>;
 };
 
+&can_clk {
+	clock-frequency = <48000000>;
+};
+
 &pfc {
 	scif0_pins: scif0 {
 		groups = "scif0_data";
@@ -81,6 +85,11 @@
 			function = "lbsc";
 		};
 	};
+
+	can0_pins: can0 {
+		groups = "can0_data", "can_clk";
+		function = "can0";
+	};
 };
 
 &scif0 {
@@ -96,3 +105,10 @@
 
 	status = "okay";
 };
+
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
