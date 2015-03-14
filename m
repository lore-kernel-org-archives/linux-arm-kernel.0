From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 14 Mar 2015 12:47:47 -0300
Subject: [PATCH 1/2] ARM: dts: imx6sl: Add label snvs_rtc
Message-ID: <1426348068-17745-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

It may be useful to disable the internal snvs-rtc when an external rtc is
available. This patch adds a label so that dts files can disable it.

Based on a patch from Markus Pargmann for imx6qdl.dtsi.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ea682e3..a78e715 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -569,7 +569,7 @@
 				#size-cells = <1>;
 				ranges = <0 0x020cc000 0x4000>;
 
-				snvs-rtc-lp at 34 {
+				snvs_rtc: snvs-rtc-lp at 34 {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
 					reg = <0x34 0x58>;
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1
