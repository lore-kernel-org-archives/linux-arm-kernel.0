From: marco.franchi@nxp.com (Marco Franchi)
Date: Wed, 18 Oct 2017 17:29:47 -0200
Subject: [PATCH v2 2/6] ARM: dts: imx51-ts4800: Fix 'port@0' node with unit
 name and no reg property
In-Reply-To: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
References: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1508354991-18016-2-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /display-di0/port at 0 has a unit name, 
but no reg property

Fix this warning by removing '@' from such node.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
-rebased to imx/dt branch
 arch/arm/boot/dts/imx51-ts4800.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 35a1112..564233e 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -71,7 +71,7 @@
 			};
 		};
 
-		port at 0 {
+		port {
 			display0_in: endpoint {
 				remote-endpoint = <&ipu_di0_disp1>;
 			};
-- 
2.7.4
