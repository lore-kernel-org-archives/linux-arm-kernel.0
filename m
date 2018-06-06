From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  6 Jun 2018 11:30:45 +0200
Subject: [PATCH] ARM: dts: imx6: RDU2: correct touchscreen axis inversion
Message-ID: <20180606093045.9215-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RMI4 touchscreen driver applied inversion and axis swap in the
wrong order, violating the DT binding for those properties. This is
fixed now, so correct the RDU2 DT to apply the inversion to the
correct axis.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 911f7f0e3cea..605ec969a859 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -558,14 +558,14 @@
 
 		rmi4-f11 at 11 {
 			reg = <0x11>;
-			touchscreen-inverted-y;
+			touchscreen-inverted-x;
 			touchscreen-swapped-x-y;
 			syna,sensor-type = <1>;
 		};
 
 		rmi4-f12 at 12 {
 			reg = <0x12>;
-			touchscreen-inverted-y;
+			touchscreen-inverted-x;
 			touchscreen-swapped-x-y;
 			syna,sensor-type = <1>;
 		};
-- 
2.17.1
