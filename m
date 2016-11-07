From: Frank.Li@nxp.com (Frank Li)
Date: Mon, 7 Nov 2016 11:30:49 -0600
Subject: [PATCH V3 2/2] ARM: dts: add new compatible stream for i.MX6QP mmdc
In-Reply-To: <1478539849-10834-1-git-send-email-Frank.Li@nxp.com>
References: <1478539849-10834-1-git-send-email-Frank.Li@nxp.com>
Message-ID: <1478539849-10834-2-git-send-email-Frank.Li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMDC has a slightly different programming model between imx6q and imx6qp
in terms of perf support, it's exactly same for suspend support, so we
have fsl,imx6q-mmdc here to save patching suspend driver with the new
compatible.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from V3 to V2
- change commit message to show suspend need fsl,imx6q-mmdc

 arch/arm/boot/dts/imx6qp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 886dbf2..e0fdd0f 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -85,5 +85,12 @@
 		pcie: pcie at 0x01000000 {
 			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
 		};
+
+		aips-bus at 02100000 {
+			mmdc0: mmdc at 021b0000 { /* MMDC0 */
+				compatible = "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
+				reg = <0x021b0000 0x4000>;
+			};
+		};
 	};
 };
-- 
2.5.2
