From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 16 Dec 2014 11:02:41 -0200
Subject: [PATCH v2] ARM: dts: imx6qdl: Remove OCRAM clock from VPU node
Message-ID: <1418734961-4972-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/media/coda.txt:

- clock-names : Should be "ahb", "per"

The OCRAM clock is already provided inside the ocram node, so remove the OCRAM 
clock from the VPU node.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rebased against the latest imx/dt branch from Shawn

 arch/arm/boot/dts/imx6qdl.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 4fc03b7..f6c6a6e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -339,9 +339,8 @@
 				             <0 12 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "bit", "jpeg";
 				clocks = <&clks IMX6QDL_CLK_VPU_AXI>,
-					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>,
-					 <&clks IMX6QDL_CLK_OCRAM>;
-				clock-names = "per", "ahb", "ocram";
+					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>;
+				clock-names = "per", "ahb";
 				resets = <&src 1>;
 				iram = <&ocram>;
 			};
-- 
1.9.1
