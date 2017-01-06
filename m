From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:10 +0100
Subject: [PATCH 01/25] ARM: dts: r8a7743: Move RST node before SYSC node
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <a97f1dfb7f6eec1998d51e7335e265be5c6314a1.1483700969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

To preserve both alphabetical (label) and numerical ordering (unit
address).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 216cb1f37f87..ca0cda28a3eb 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -102,17 +102,17 @@
 			#power-domain-cells = <0>;
 		};
 
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7743-rst";
+			reg = <0 0xe6160000 0 0x100>;
+		};
+
 		sysc: system-controller at e6180000 {
 			compatible = "renesas,r8a7743-sysc";
 			reg = <0 0xe6180000 0 0x200>;
 			#power-domain-cells = <1>;
 		};
 
-		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a7743-rst";
-			reg = <0 0xe6160000 0 0x100>;
-		};
-
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7743",
 				     "renesas,rcar-dmac";
-- 
2.7.0.rc3.207.g0ac5344
