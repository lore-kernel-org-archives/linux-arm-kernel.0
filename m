From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Oct 2014 14:03:32 -0300
Subject: [PATCH v2] ARM: imx6q-pcie doc: Update the clocks descriptions to use
 defines
Message-ID: <1413392612-6594-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let's make the imx6q-pcie example to actually match the usage on imx6qdl.dtsi
by providing the clock names via defines rather than hardcoded numbers.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Adjust the Subject and send it to Shawn

 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 6fbba53..0b28b52 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -35,6 +35,8 @@ Example:
 		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
 		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
+		clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
+			 <&clks IMX6QDL_CLK_LVDS1_GATE>,
+			 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 		clock-names = "pcie", "pcie_bus", "pcie_phy";
 	};
-- 
1.9.1
