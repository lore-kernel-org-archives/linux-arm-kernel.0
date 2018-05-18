From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:58 +0200
Subject: [PATCH 036/102] arm64: dts: renesas: ulcb: Rename EtherAVB "mdc" pin
 group to "mdio"
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <1518ad140b9ea73cee8bc89e39f8962fbd2bb7bb.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On other Renesas SoCs, the pin group for the MDIO bus is named "mdio"
instead of "mdc".  Fix the inconsistency, now the pinctrl drivers for
R-Car H3, M3-W, and M3-N have gained support for the traditional pin
group name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 6f814845f8b6..93402783d52f 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -255,12 +255,12 @@
 
 	avb_pins: avb {
 		mux {
-			groups = "avb_link", "avb_mdc", "avb_mii";
+			groups = "avb_link", "avb_mdio", "avb_mii";
 			function = "avb";
 		};
 
-		pins_mdc {
-			groups = "avb_mdc";
+		pins_mdio {
+			groups = "avb_mdio";
 			drive-strength = <24>;
 		};
 
-- 
2.11.0
