From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Fri, 26 Feb 2016 16:38:47 +0000
Subject: [PATCH v2] arm64: dts: r8a7795: Add CAN external clock support
In-Reply-To: <CAMuHMdXJRN2kF2r=bqcY8v87aYHj_OKr2=5vzcfoHwvr02Y2CA@mail.gmail.com>
References: <CAMuHMdXJRN2kF2r=bqcY8v87aYHj_OKr2=5vzcfoHwvr02Y2CA@mail.gmail.com>
Message-ID: <1456504727-54332-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds external CAN clock node for r8a7795. This clock can be used as
fCAN clock of CAN and CAN FD controller.

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
Thanks Geert for the comments. Added status property as discussed
here (http://www.spinics.net/lists/arm-kernel/msg486931.html)
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a7315eb..4049182 100644
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
1.9.1
