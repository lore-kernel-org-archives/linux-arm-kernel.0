From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:31:41 +0900
Subject: [PATCH 5/8] ARM: shmobile: r8a7790: Rename VSP1_(SY|RT) clocks to
 VSP1_(S|R)
In-Reply-To: <cover.1397694178.git.horms+renesas@verge.net.au>
References: <cover.1397694178.git.horms+renesas@verge.net.au>
Message-ID: <79ea9934b8df700fa306c8ced2d3bbf94ff276a8.1397694178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The r8a7790 has four VSP1 instances, two of them being named VSPS (which
stands for "VSP Standard") and VSPR (which stands for "VSP for
Resizing"). The clock section in the SoC datasheet misunderstood the
abbreviations as meaning VSP System and VSP Realtime, and named the
corresponding clocks VSP1(SY) and VSP1(RT). This mistake has been
carried over to the kernel code.

Fix this by renaming the VSP1_SY and VSP1_RT clocks to VSP1_S and VSP1_R.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 2 +-
 include/dt-bindings/clock/r8a7790-clock.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 618e5b5..10b326b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -673,7 +673,7 @@
 			renesas,clock-indices = <
 				R8A7790_CLK_TMU1 R8A7790_CLK_TMU3 R8A7790_CLK_TMU2
 				R8A7790_CLK_CMT0 R8A7790_CLK_TMU0 R8A7790_CLK_VSP1_DU1
-				R8A7790_CLK_VSP1_DU0 R8A7790_CLK_VSP1_RT R8A7790_CLK_VSP1_SY
+				R8A7790_CLK_VSP1_DU0 R8A7790_CLK_VSP1_R R8A7790_CLK_VSP1_S
 			>;
 			clock-output-names =
 				"tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 6548a5f..9a7c4c5 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -33,8 +33,8 @@
 #define R8A7790_CLK_TMU0		25
 #define R8A7790_CLK_VSP1_DU1		27
 #define R8A7790_CLK_VSP1_DU0		28
-#define R8A7790_CLK_VSP1_RT		30
-#define R8A7790_CLK_VSP1_SY		31
+#define R8A7790_CLK_VSP1_R		30
+#define R8A7790_CLK_VSP1_S		31
 
 /* MSTP2 */
 #define R8A7790_CLK_SCIFA2		2
-- 
1.8.4
