From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 28 Nov 2014 16:23:46 +0100
Subject: [PATCH] ARM: dts: imx6qdl: Fix CODA960 interrupt order
Message-ID: <1417188226-21756-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a04a0b6fed4f ("ARM: dts: imx6qdl: Enable CODA960 VPU") lost the
fix for the CODA960 interrupt order during a rebase before being applied.
This patch adds the missing bit and brings the interrupts and
interrupt-names properties back in sync.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 4fc03b7..2109d07 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -335,8 +335,8 @@
 			vpu: vpu at 02040000 {
 				compatible = "cnm,coda960";
 				reg = <0x02040000 0x3c000>;
-				interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>,
-				             <0 12 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0 12 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 3 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "bit", "jpeg";
 				clocks = <&clks IMX6QDL_CLK_VPU_AXI>,
 					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>,
-- 
2.1.3
