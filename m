From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:39 +0200
Subject: [PATCH 44/58] arm64: dts: renesas: v3hsk: Move lvds0 node
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <47d7f6822864a8cf2f09d27cb1321bd36ab6d9e4.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

To preserve alphabetical sort order.

Fixes: 4edac426aff11a37 ("arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
index 44ab7344f8aa..dd14a41b32cd 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -119,18 +119,6 @@
 	};
 };
 
-&lvds0 {
-	status = "okay";
-
-	ports {
-		port at 1 {
-			lvds0_out: endpoint {
-				remote-endpoint = <&thc63lvd1024_in>;
-			};
-		};
-	};
-};
-
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -177,6 +165,18 @@
 	};
 };
 
+&lvds0 {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			lvds0_out: endpoint {
+				remote-endpoint = <&thc63lvd1024_in>;
+			};
+		};
+	};
+};
+
 &pfc {
 	gether_pins: gether {
 		groups = "gether_mdio_a", "gether_rgmii",
-- 
2.11.0
