From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:23 +0200
Subject: [PATCH 27/30] arm64: dts: r8a7795: salvator-x: Configure pins for the
 DU RGB output
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <272bde03842b2e89892f876cb2d2285c2ae7eada.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 64a29a87a724..b1eab6876f8c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -181,6 +181,8 @@
 };
 
 &du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	ports {
@@ -227,6 +229,11 @@
 		function = "avb";
 	};
 
+	du_pins: du {
+		groups = "du_rgb888", "du_sync", "du_oddf", "du_clk_out_0";
+		function = "du";
+	};
+
 	sdhi0_pins: sd0 {
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
-- 
2.7.0.rc3.207.g0ac5344
