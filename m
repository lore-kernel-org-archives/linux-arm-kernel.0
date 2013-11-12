From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 12 Nov 2013 09:50:08 +0100
Subject: [PATCH v7 5/7] ARM: dts: imx27 phycore move uart1 to rdk
In-Reply-To: <1384246210-9257-1-git-send-email-mpa@pengutronix.de>
References: <1384246210-9257-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1384246210-9257-6-git-send-email-mpa@pengutronix.de>
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
1.8.4.2
