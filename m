From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Sat,  2 Apr 2016 18:25:44 +0200
Subject: [PATCH v3 2/9] ARM: dts: imx7d: add flexcan support
In-Reply-To: <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
 <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1459614351-16731-3-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device nodes for the i.MX7 FlexCAN buses.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---

Changes v1 -> v2:
- none
Changes v2 -> v3:
- Re-order flexcan nodes by unit-address order
- Remove flexcan unnecessary stop-mode property

---
 arch/arm/boot/dts/imx7d.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 2547e16..6b3faa2 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -704,6 +704,26 @@
 				status = "disabled";
 			};
 
+			flexcan1: can at 30a00000 {
+				compatible = "fsl,imx7d-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x30a00000 0x10000>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_CLK_DUMMY>,
+					<&clks IMX7D_CAN1_ROOT_CLK>;
+				clock-names = "ipg", "per";
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
+				status = "disabled";
+			};
+
 			i2c1: i2c at 30a20000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.7.0
