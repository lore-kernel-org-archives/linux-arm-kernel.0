From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Mon, 27 Aug 2018 10:01:27 +0200
Subject: [PATCH v2 1/1] ARM: dts: imx6ul: Add weim node
Message-ID: <20180827080127.15972-1-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add weim node for i.MX6UL SOC.

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---

Changes for v2:
 - Use GIC_SPI macro

 arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 47a3453a4211..eea132359fc0 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -912,6 +912,17 @@
 				reg = <0x021b0000 0x4000>;
 			};
 
+			weim: weim at 21b8000 {
+				#address-cells = <2>;
+				#size-cells = <1>;
+				compatible = "fsl,imx6ul-weim", "fsl,imx6q-weim";
+				reg = <0x021b8000 0x4000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_EIM>;
+				fsl,weim-cs-gpr = <&gpr>;
+				status = "disabled";
+			};
+
 			ocotp: ocotp-ctrl at 21bc000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.16.4
