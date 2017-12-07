From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:08 +0100
Subject: [PATCH 05/54] arm64: dts: renesas: eagle: Move avb node to preserve
 sort order
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <d0ff035f89f18424fd7665b9a29c547adafdea38.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index a711e77cc6a5..9e37f6e7b265 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -33,6 +33,17 @@
 	};
 };
 
+&avb {
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+	};
+};
+
 &extal_clk {
 	clock-frequency = <16666666>;
 };
@@ -44,14 +55,3 @@
 &scif0 {
 	status = "okay";
 };
-
-&avb {
-	renesas,no-ether-link;
-	phy-handle = <&phy0>;
-	status = "okay";
-
-	phy0: ethernet-phy at 0 {
-		rxc-skew-ps = <1500>;
-		reg = <0>;
-	};
-};
-- 
2.11.0
