From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 11:09:04 +0100
Subject: [PATCHv2 11/16] ARM: dts: imx6ul: add lcdif support
In-Reply-To: <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453284549-16363-12-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device node for the i.MX6UL eLCDIF interface.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index e1fda39e..985c1b1 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -798,6 +798,17 @@
 				reg = <0x021b0000 0x4000>;
 			};
 
+			lcdif: lcdif at 021c8000 {
+				compatible = "fsl,imx6ul-lcdif", "fsl,imx28-lcdif";
+				reg = <0x021c8000 0x4000>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
+					 <&clks IMX6UL_CLK_LCDIF_APB>,
+					 <&clks IMX6UL_CLK_DUMMY>;
+				clock-names = "pix", "axi", "disp_axi";
+				status = "disabled";
+			};
+
 			qspi: qspi at 021e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.1.4
