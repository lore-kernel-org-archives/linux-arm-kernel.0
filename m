From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:21 +0200
Subject: [PATCH 02/26] ARM: dts: blanche: add SCIF0/3 pins
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <2cd452d19e6e79ea58c8022c43248b64d579db60.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the (previously omitted) SCIF0/3 pin data to the Blanche board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792-blanche.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index e7b40f0e7da6..9b550bde939a 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -57,10 +57,28 @@
 	clock-frequency = <20000000>;
 };
 
+&pfc {
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+
+	scif3_pins: scif3 {
+		groups = "scif3_data";
+		function = "scif3";
+	};
+};
+
 &scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
 &scif3 {
+	pinctrl-0 = <&scif3_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
2.7.0.rc3.207.g0ac5344
