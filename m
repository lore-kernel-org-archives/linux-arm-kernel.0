From: d.schultz@phytec.de (Daniel Schultz)
Date: Fri, 2 Dec 2016 15:45:48 +0100
Subject: [PATCH 2/3] ARM: dts: imx6ul: Add OCOTP node
In-Reply-To: <1480689949-17957-1-git-send-email-d.schultz@phytec.de>
References: <1480689949-17957-1-git-send-email-d.schultz@phytec.de>
Message-ID: <1480689949-17957-2-git-send-email-d.schultz@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device node adds OCOTP for the i.MX6UL SoC.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c5c05fd..ee53795 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -849,6 +849,12 @@
 				reg = <0x021b0000 0x4000>;
 			};
 
+			ocotp: ocotp at 021bc000 {
+				compatible = "fsl,imx6ul-ocotp";
+				reg = <0x021bc000 0x4000>;
+				clocks = <&clks IMX6UL_CLK_OCOTP>;
+			};
+
 			lcdif: lcdif at 021c8000 {
 				compatible = "fsl,imx6ul-lcdif", "fsl,imx28-lcdif";
 				reg = <0x021c8000 0x4000>;
-- 
1.9.1
