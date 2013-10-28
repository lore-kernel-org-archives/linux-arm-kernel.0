From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Oct 2013 10:00:41 +0100
Subject: [PATCH v6 6/8] ARM: dts: imx27 phycore move uart1 to rdk
In-Reply-To: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1382950843-26066-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uart1 is not used on SOM. It is passed directly to the rdk board.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 1 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 0fc6551..ad76d88 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -29,6 +29,7 @@
 
 &uart1 {
 	fsl,uart-has-rtscts;
+	status = "okay";
 };
 
 &uart2 {
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index 4ec402c..648541a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -165,10 +165,6 @@
 	status = "okay";
 };
 
-&uart1 {
-	status = "okay";
-};
-
 &weim {
 	status = "okay";
 
-- 
1.8.4.rc3
