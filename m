From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Feb 2015 17:04:09 +0100
Subject: [PATCH] ARM: dts: imx6qdl, Add label snvs_rtc
Message-ID: <1424448249-30718-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It may be useful to disable the internal rtc snvs-rtc because an
external rtc is available. This patch adds a label so that board files
can disable this rtc.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2109d0763c1b..460a2953a841 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -659,7 +659,7 @@
 				#size-cells = <1>;
 				ranges = <0 0x020cc000 0x4000>;
 
-				snvs-rtc-lp at 34 {
+				snvs_rtc: snvs-rtc-lp at 34 {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
 					reg = <0x34 0x58>;
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.1.4
