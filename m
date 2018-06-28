From: nick@shmanahar.org (Nick Dyer)
Date: Thu, 28 Jun 2018 23:56:26 +0100
Subject: [PATCH v1] ARM: dts: imx51-zii-rdu1: correct touchscreen axis
 inversion
Message-ID: <20180628225626.26203-1-nick@shmanahar.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RMI4 touchscreen driver applied inversion and axis swap in the
wrong order, violating the DT binding for those properties. This was fixed in
645a397, so correct the RDU1 DT to apply the inversion to the
correct axis.

Tested on Zii RDU1 00-5105-30 rev B

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 68f5c1d5ecd0..b1d83fb08150 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -553,7 +553,7 @@
 
 		rmi4-f11 at 11 {
 			reg = <0x11>;
-			touchscreen-inverted-y;
+			touchscreen-inverted-x;
 			touchscreen-swapped-x-y;
 			syna,sensor-type = <1>;
 		};
-- 
2.17.1
