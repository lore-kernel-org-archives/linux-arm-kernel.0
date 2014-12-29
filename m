From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:48 +0900
Subject: [PATCH 17/30] ARM: shmobile: r8a7779: Use R8A7779_CLK_P as SCIF
 parent clock
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <c6ce3cdfce6c0214f178fbad73d138dd1f1b04f6.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Use R8A7779_CLK_P as parent clock for SCIF devices on r8a7779.
With this change in place the SCIF CCF handling matches the
legacy clock code. Also, this matches the data sheet.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index e3846af..ee3bb3e 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -464,12 +464,12 @@
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>,
 				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
-- 
2.1.3
