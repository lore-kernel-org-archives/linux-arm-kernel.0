From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Sep 2015 12:55:21 -0300
Subject: [PATCH v2] ARM: dts: imx6sl: Complete the dcp node
Message-ID: <1441209321-28331-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The DCP block present on MX6SL is compatible with the one on MX28,
so add the compatible string and also complete the interrupt entries.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Use compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp"; as suggested by
Lucas Stach

 arch/arm/boot/dts/imx6sl.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 320a27f..b105735 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -670,8 +670,12 @@
 			};
 
 			dcp: dcp at 020fc000 {
+				compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";
 				reg = <0x020fc000 0x4000>;
-				interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 100 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 101 IRQ_TYPE_LEVEL_HIGH>;
+				status = "okay";
 			};
 		};
 
-- 
1.9.1
