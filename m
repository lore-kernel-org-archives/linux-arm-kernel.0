From: marex@denx.de (Marek Vasut)
Date: Thu, 24 Jul 2014 04:08:18 +0200
Subject: [PATCH] ARM: dts: mxs: Fix the RTC compatible prop on M28EVK
Message-ID: <1406167698-7018-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 3048fa3fc5b6c641a06e959925dfbc31649528e9 upstream.

The compatible property should be m41t62, not mt41t62, so fix this.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: <stable@vger.kernel.org> # 3.14.x
---
 arch/arm/boot/dts/imx28-m28evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

NOTE: Without this backport, the RTC clock on this device is not available
      and the system time is completely random upon each boot.

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index e6d0fa6..f3e58f1 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -194,7 +194,7 @@
 				};
 
 				rtc: rtc at 68 {
-					compatible = "stm,mt41t62";
+					compatible = "stm,m41t62";
 					reg = <0x68>;
 				};
 			};
-- 
2.0.1
