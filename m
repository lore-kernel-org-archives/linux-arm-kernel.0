From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  1 Jun 2013 09:54:12 +0400
Subject: [PATCH 3/4] ARM: dts: imx27-phytec-phycore-som: Remove UART
 definitions
In-Reply-To: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
References: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370066053-25030-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART1 and UART2 can be unused on some designs with PCM038 module.
Remove these definitions from basic dts and lets choose user only
necessary UARTs in custom designs.
Keep UART0 for using this one as boot console, but since we have
not way to disable usage RTSCTS signals, remove this parameter for UART0.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index a4c0256..73f4b28 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -23,17 +23,6 @@
 	soc {
 		aipi at 10000000 { /* aipi1 */
 			serial at 1000a000 {
-				fsl,uart-has-rtscts;
-				status = "okay";
-			};
-
-			serial at 1000b000 {
-				fsl,uart-has-rtscts;
-				status = "okay";
-			};
-
-			serial at 1000c000 {
-				fsl,uart-has-rtscts;
 				status = "okay";
 			};
 
-- 
1.8.1.5
