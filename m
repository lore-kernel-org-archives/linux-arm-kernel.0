From: dirk.behme@gmail.com (Dirk Behme)
Date: Fri,  4 Dec 2015 14:38:53 +0100
Subject: [PATCH 3/3] arm64: dts: r8a7795: Add pmu device nodes
In-Reply-To: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <1449236333-4410-3-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>

Enabling the performance monitor unit on r8a7795.

Signed-off-by: Masaru Nagai <masaru.nagai.vx@renesas.com>
Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Note: This patch picked from

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/log/?h=v4.2/rcar-3.0.x

and rebased against

https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/gen3-latest renesas-drivers-2015-12-01-v4.4-rc3

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 946a5bb..8113b71 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -247,6 +247,18 @@
 			power-domains = <&cpg>;
 		};
 
+		pmu {
+			compatible = "arm,armv8-pmuv3";
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-affinity = <&a57_0>,
+					     <&a57_1>,
+					     <&a57_2>,
+					     <&a57_3>;
+		};
+
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <GIC_PPI 13
-- 
2.6.3
