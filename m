From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:46 +0900
Subject: [PATCH 03/15] ARM: shmobile: r8a7794: alt: Enable PFC DU for the VGA
 port
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
Message-ID: <13b8b8e8fae6bc38941bc5e5e847706beb004082.1448586938.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Tie in r8a7794 PFC DU support to the VGA port on the
r8a7794 ALT board.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index fd1cfcdd65ef..b255a8791841 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -80,6 +80,8 @@
 };
 
 &du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
@@ -101,6 +103,11 @@
 };
 
 &pfc {
+	du_pins: du {
+		renesas,groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_dotclkout0";
+		renesas,function = "du";
+	};
+
 	scif2_pins: serial2 {
 		renesas,groups = "scif2_data";
 		renesas,function = "scif2";
-- 
2.1.4
