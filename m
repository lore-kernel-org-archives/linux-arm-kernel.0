From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 15 Mar 2016 11:30:18 +0100
Subject: [PATCH 1/9] ARM: dts: imx7d: add lcdif support
In-Reply-To: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1458037826-19375-2-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device node for the i.MX7 eLCDIF interface.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b5a50e0..a768716 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -608,6 +608,17 @@
 				status = "disabled";
 			};
 
+			lcdif: lcdif at 30730000 {
+				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				reg = <0x30730000 0x10000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
+					<&clks IMX7D_CLK_DUMMY>,
+					<&clks IMX7D_CLK_DUMMY>;
+				clock-names = "pix", "axi", "disp_axi";
+				status = "disabled";
+			};
+
 			pwm1: pwm at 30660000 {
 				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
 				reg = <0x30660000 0x10000>;
-- 
2.7.0
