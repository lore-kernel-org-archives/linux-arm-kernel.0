From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Oct 2012 11:30:10 +0100
Subject: [PATCH 3/3] ARM: dts: cfa10049: Add the DH2228FV DAC to the DTS
In-Reply-To: <1351679410-11026-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1351679410-11026-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1351679410-11026-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no driver for it yet, so it will use spidev.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 05c892e..2ef7ce6 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -29,6 +29,7 @@
 						0x01c1 /* MX28_PAD_GPMI_RESETN__SSP3_CMD */
 						0x0111 /* MX28_PAD_GPMI_CE1N__SSP3_D3 */
 						0x01a2 /* MX28_PAD_GPMI_ALE__SSP3_D4 */
+						0x01b2 /* MX28_PAD_GPMI_CLE__SSP3_D5 */
 					>;
 					fsl,drive-strength = <1>;
 					fsl,voltage = <1>;
@@ -60,6 +61,11 @@
 					spi-max-frequency = <100000>;
 				};
 
+				dac0: dh2228 at 2 {
+					compatible = "rohm,dh2228fv";
+					reg = <2>;
+					spi-max-frequency = <100000>;
+				};
 			};
 		};
 
-- 
1.7.9.5
