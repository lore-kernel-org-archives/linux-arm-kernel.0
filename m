From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Sat, 20 Feb 2016 11:20:50 +0100
Subject: [PATCH 2/4] ARM: dts: imx6ul: Add LCDIF support
In-Reply-To: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
Message-ID: <1455963652-24618-3-git-send-email-michael@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for LCDIF.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index cd32d1d..f369fa4 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -696,6 +696,17 @@
 				reg = <0x021b0000 0x4000>;
 			};
 
+			lcdif: lcdif at 021c8000 {
+				compatible = "fsl,imx6ul-lcdif", "fsl,imx28-lcdif";
+				reg = <0x021c8000 0x4000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
+					<&clks IMX6UL_CLK_LCDIF_APB>,
+					<&clks IMX6UL_CLK_DUMMY>;
+				clock-names = "pix", "axi", "disp_axi";
+				status = "disabled";
+			};
+
 			qspi: qspi at 021e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.7.0
