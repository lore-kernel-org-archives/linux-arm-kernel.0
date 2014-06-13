From: marex@denx.de (Marek Vasut)
Date: Fri, 13 Jun 2014 02:22:39 +0200
Subject: [PATCH 1/2] ARM: dts: mx5: Fix IPU port node placement
Message-ID: <1402618960-9735-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "port" node was misplaced in the original patch, therefore making
the LCD dysfunctional on this board. Fix this by moving the "port" DT
node into the "display {}" node.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index d5d146a..3a04b9e 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -43,11 +43,11 @@
 					vsync-active = <1>;
 				};
 			};
-		};
 
-		port {
-			display1_in: endpoint {
-				remote-endpoint = <&ipu_di1_disp1>;
+			port {
+				display1_in: endpoint {
+					remote-endpoint = <&ipu_di1_disp1>;
+				};
 			};
 		};
 	};
-- 
2.0.0.rc2
