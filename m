From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 18 Sep 2018 08:43:31 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-zii-rdu1: Fix the rtc compatible string
Message-ID: <1537271012-5159-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/rtc/rtc-ds1307.txt the
original compatible "maxim,ds1341" is not a valid entry.

Switch to the documented "dallas,ds1341" compatible.

Reported-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 469cce2..e45a15c 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -508,7 +508,7 @@
 	};
 
 	ds1341: rtc at 68 {
-		compatible = "maxim,ds1341";
+		compatible = "dallas,ds1341";
 		reg = <0x68>;
 	};
 
-- 
2.7.4
