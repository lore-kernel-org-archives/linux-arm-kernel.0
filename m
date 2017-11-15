From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Nov 2017 10:03:53 -0200
Subject: [PATCH] Revert "ARM: dts: imx53: add srtc node"
Message-ID: <1510747433-23503-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

This reverts commit 5b725054147deaf966b3919e10a86c6bfe946a18.

The rtc block on i.MX53 is a completely different hardware than the
one found on i.MX25.

Cc: <stable@vger.kernel.org> #4.14
Reported-by: Noel Vellemans <Noel.Vellemans@visionbms.com>
Suggested-by: Juergen Borleis <jbe@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 8bf0d89..2e516f4 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -433,15 +433,6 @@
 				clock-names = "ipg", "per";
 			};
 
-			srtc: srtc at 53fa4000 {
-				compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
-				reg = <0x53fa4000 0x4000>;
-				interrupts = <24>;
-				interrupt-parent = <&tzic>;
-				clocks = <&clks IMX5_CLK_SRTC_GATE>;
-				clock-names = "ipg";
-			};
-
 			iomuxc: iomuxc at 53fa8000 {
 				compatible = "fsl,imx53-iomuxc";
 				reg = <0x53fa8000 0x4000>;
-- 
2.7.4
