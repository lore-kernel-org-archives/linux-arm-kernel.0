From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  1 Jun 2013 09:54:10 +0400
Subject: [PATCH 1/4] ARM: dts: imx27-phytec-phycore: Add reset GPIO for FEC
Message-ID: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FEC (KSZ8001L) reset pin is connected to GPIOC30.
Add this definition to dts.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore.dts
index eb7d9fa..a4c0256 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dts
@@ -58,6 +58,7 @@
 
 		aipi at 10020000 { /* aipi2 */
 			ethernet at 1002b000 {
+				phy-reset-gpios = <&gpio3 30 0>;
 				status = "okay";
 			};
 		};
-- 
1.8.1.5
