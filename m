From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:31:42 +0900
Subject: [PATCH 6/8] ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S
In-Reply-To: <cover.1397694178.git.horms+renesas@verge.net.au>
References: <cover.1397694178.git.horms+renesas@verge.net.au>
Message-ID: <58ea1d53ba93620ac50fef9d9720b2323971f243.1397694178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The r8a7791 has three VSP1 instances, one of them being named VSPS (which
stands for "VSP Standard"). The clock section in the SoC datasheet
misunderstood the abbreviation as meaning VSP System, and named the
corresponding clock VSP1(SY). This mistake has been carried over to the
kernel code.

Fix this by renaming the VSP1_SY clock to VSP1_S.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 2 +-
 include/dt-bindings/clock/r8a7791-clock.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 4618170..aa1cba9 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -688,7 +688,7 @@
 			renesas,clock-indices = <
 				R8A7791_CLK_TMU1 R8A7791_CLK_TMU3 R8A7791_CLK_TMU2
 				R8A7791_CLK_CMT0 R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1
-				R8A7791_CLK_VSP1_DU0 R8A7791_CLK_VSP1_SY
+				R8A7791_CLK_VSP1_DU0 R8A7791_CLK_VSP1_S
 			>;
 			clock-output-names =
 				"tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 30f82f2..f069bc6 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -32,7 +32,7 @@
 #define R8A7791_CLK_TMU0		25
 #define R8A7791_CLK_VSP1_DU1		27
 #define R8A7791_CLK_VSP1_DU0		28
-#define R8A7791_CLK_VSP1_SY		31
+#define R8A7791_CLK_VSP1_S		31
 
 /* MSTP2 */
 #define R8A7791_CLK_SCIFA2		2
-- 
1.8.4
