From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:12 +0100
Subject: [PATCH 15/20] ARM: ux500: Add a vmmc regulator through DT for the
 poped eMMC for href
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-16-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node in DT for the proper regulator which means we can move away
from the mmci platform data which currently holds the corresponding OCR
mask.

The mmci driver can then calculate the OCR mask based on the voltages
supported by the regulator, instead of relying on the platform data.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index be34beb..bf449de 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -155,6 +155,7 @@
 			bus-width = <8>;
 			cap-mmc-highspeed;
 			non-removable;
+			vmmc-supply = <&db8500_vsmps2_reg>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi2_default_mode>;
 			pinctrl-1 = <&sdi2_sleep_mode>;
-- 
1.7.9.5
