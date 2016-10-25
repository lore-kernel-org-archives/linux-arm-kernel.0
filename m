From: Frank.Li@nxp.com (Frank Li)
Date: Tue, 25 Oct 2016 16:26:57 -0500
Subject: [PATCH 2/2] ARM: dts: add new compatible stream for i.MX6QP mmdc
In-Reply-To: <1477430817-20381-1-git-send-email-Frank.Li@nxp.com>
References: <1477430817-20381-1-git-send-email-Frank.Li@nxp.com>
Message-ID: <1477430817-20381-2-git-send-email-Frank.Li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmdc of i.MX6QP are little difference with i.MX6Q.
added new compatible stream fsl,imx6qp-mmdc

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
