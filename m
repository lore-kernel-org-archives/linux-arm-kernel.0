From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Fri,  1 Apr 2016 17:19:30 -0400
Subject: [PATCH] arm: dts: imx6q-ba16: Disable pwm2 by default
Message-ID: <1459545570-16390-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Justin Waters <justin.waters@timesys.com>

pwm2 is provided on the BA16 Q7 module, but is not used on any
of the current configurations. However, future platforms may
utilize this device, so we are simply disabling the node rather
than removing it completely.

Signed-off-by: Justin Waters <justin.waters@timeys.com>
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-ba16.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index fcc7b50..3f33a2a 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -337,7 +337,7 @@
 &pwm2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
-	status = "okay";
+	status = "disabled";
 };
 
 &sata {
-- 
2.8.0
