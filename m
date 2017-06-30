From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Jun 2017 17:43:02 -0300
Subject: [PATCH 1/4] ARM: dts: imx7d-sdb: Put pinctrl_spi4 in the correct
 location
Message-ID: <1498855385-9690-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

pinctrl_spi4 pin group is not part of the low power iomux controller,
so move it under the normal iomuxc node.

Fixes: 184f39b57cab6 ("ARM: dts: imx7d-sdb: Add GPIO expander node")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 54c4540..0a24d1b 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -557,6 +557,14 @@
 			>;
 		};
 
+		pinctrl_spi4: spi4grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
+				MX7D_PAD_GPIO1_IO12__GPIO1_IO12	0x59
+				MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x59
+			>;
+		};
+
 		pinctrl_tsc2046_pendown: tsc2046_pendown {
 			fsl,pins = <
 				MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x59
@@ -697,13 +705,5 @@
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT		0x110b0
 		>;
-
-		pinctrl_spi4: spi4grp {
-			fsl,pins = <
-				MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
-				MX7D_PAD_GPIO1_IO12__GPIO1_IO12	0x59
-				MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x59
-			>;
-		};
 	};
 };
-- 
2.7.4
