From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 15 Mar 2016 15:04:21 +0100
Subject: [PATCH v2 2/9] ARM: dts: imx7d: add flexcan support
In-Reply-To: <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1458050668-26748-3-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device nodes for the i.MX7 FlexCAN buses.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---

Changelog v1 -> v2:
- none

---
 arch/arm/boot/dts/imx7d.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index a768716..c5e47a4 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -930,6 +930,28 @@
 				fsl,num-rx-queues=<3>;
 				status = "disabled";
 			};
+
+			flexcan1: can at 30a00000 {
+				compatible = "fsl,imx7d-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x30a00000 0x10000>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_CLK_DUMMY>,
+					<&clks IMX7D_CAN1_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				stop-mode = <&gpr 0x10 1 0x10 17>;
+				status = "disabled";
+			};
+
+			flexcan2: can at 30a10000 {
+				compatible = "fsl,imx7d-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x30a10000 0x10000>;
+				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_CLK_DUMMY>,
+					<&clks IMX7D_CAN2_ROOT_CLK>;
+				clock-names = "ipg", "per";
+				stop-mode = <&gpr 0x10 2 0x10 18>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.7.0
