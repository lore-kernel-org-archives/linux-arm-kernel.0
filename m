From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 18:21:26 +0100
Subject: [PATCH 09/14] ARM: dts: imx6ul: add sdma support
In-Reply-To: <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-8-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452619291-13625-10-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index a578b23..96b78a9 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -556,6 +556,17 @@
 				clock-names = "ipg", "per";
 			};
 
+			sdma: sdma at 020ec000 {
+				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
+				reg = <0x020ec000 0x4000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_SDMA>,
+					 <&clks IMX6UL_CLK_SDMA>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
+			};
+
 			pwm5: pwm at 020f0000 {
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020f0000 0x4000>;
-- 
2.1.4
