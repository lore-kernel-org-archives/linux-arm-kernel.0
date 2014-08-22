From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 21 Aug 2014 22:59:32 -0300
Subject: [PATCH] ARM: dts: imx28-evk: Fix display duplicate name warning
Message-ID: <1408672772-6365-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Provide the display unit address in order to fix the following warning:

[    0.114765] regulator-dummy: no parameters
[    0.152091] device-tree: Duplicate name in lcdif at 80030000, renamed to "display#1"

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index e4cc44c..c258b2c 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -127,7 +127,7 @@
 				display = <&display>;
 				status = "okay";
 
-				display: display {
+				display: display at 0 {
 					bits-per-pixel = <32>;
 					bus-width = <24>;
 
-- 
1.9.1
