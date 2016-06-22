From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed, 22 Jun 2016 10:25:56 -0400
Subject: [PATCH] ARM: dts: imx6q-bx50v3: Add gpio power off support
Message-ID: <1466605556-11009-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ken Lin <ken.lin@advantech.com.tw>

bx50v3 boards can be powered off via GPIO, this patch specifies the GPIO to
be used with the gpio-poweroff driver.

Signed-off-by: Ken Lin <ken.lin@advantech.com.tw>
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index bb66dfd..cf3fd31 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -52,6 +52,12 @@
 		};
 	};
 
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
+
 	reg_wl18xx_vmmc: regulator-wl18xx {
 		compatible = "regulator-fixed";
 		regulator-name = "vwl1807";
-- 
2.8.1
