From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:04 +0100
Subject: [PATCH 07/20] ARM: ux500: Add mmci signal directions in DT for href
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-8-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 6cb9b68..d50fe24 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mmc/mmci.h>
 #include "ste-dbx5x0.dtsi"
 #include "ste-href-family-pinctrl.dtsi"
 
@@ -118,6 +119,10 @@
 			bus-width = <4>;
 			mmc-cap-sd-highspeed;
 			mmc-cap-mmc-highspeed;
+			signal-direction = <(MCI_ST_DATA2DIREN |
+						MCI_ST_CMDDIREN |
+						MCI_ST_DATA0DIREN |
+						MCI_ST_FBCLKEN)>;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
 			pinctrl-names = "default", "sleep";
-- 
1.7.9.5
