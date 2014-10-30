From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:54:29 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Fix flash partition label and size in
 device tree
Message-ID: <1414648469-29947-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

The size and the name of flash partition are consistent
across use the R-Car Gen2 series.

This patch makes the koelsch board consistent with the lager board.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[simon: reworded changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

 arch/arm/boot/dts/r8a7791-koelsch.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 523ae4d..90587f0 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -390,17 +390,17 @@
 
 		partition at 0 {
 			label = "loader";
-			reg = <0x00000000 0x00080000>;
+			reg = <0x00000000 0x00040000>;
 			read-only;
 		};
-		partition at 80000 {
-			label = "bootenv";
-			reg = <0x00080000 0x00080000>;
+		partition at 40000 {
+			label = "user";
+			reg = <0x00040000 0x00400000>;
 			read-only;
 		};
-		partition at 100000 {
-			label = "data";
-			reg = <0x00100000 0x03f00000>;
+		partition at 440000 {
+			label = "flash";
+			reg = <0x00440000 0x03bc0000>;
 		};
 	};
 };
-- 
2.1.1
