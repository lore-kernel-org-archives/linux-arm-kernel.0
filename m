From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:21 +0900
Subject: [PATCH 1/3] arm64: dts: r8a7795: Add CAN external clock support
In-Reply-To: <cover.1459731817.git.horms+renesas@verge.net.au>
References: <cover.1459731817.git.horms+renesas@verge.net.au>
Message-ID: <7811482f0e2521249bb6cf76dffd863a3dda8e07.1459731817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Adds external CAN clock node for r8a7795. This clock can be used as
fCAN clock of CAN and CAN FD controller.

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a7315ebe3883..4049182e6608 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -115,6 +115,14 @@
 		clock-frequency = <0>;
 	};
 
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		status = "disabled";
+	};
+
 	/* External SCIF clock - to be overridden by boards that provide it */
 	scif_clk: scif {
 		compatible = "fixed-clock";
-- 
2.1.4
