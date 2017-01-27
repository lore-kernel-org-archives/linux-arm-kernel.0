From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 16:47:25 -0800
Subject: [PATCH 2/5] ARM: dts: qcom: add charger otg regulator
In-Reply-To: <20170127004728.22490-1-stephen.boyd@linaro.org>
References: <20170127004728.22490-1-stephen.boyd@linaro.org>
Message-ID: <20170127004728.22490-3-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Bird, Tim" <Tim.Bird@sonymobile.com>

Add the otg regulator provided by the charger block.

Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
[stephen.boyd at linaro.org: Fix otg supply property name]
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index f8eb5e31c920..6b16b296f0fa 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -45,6 +45,10 @@
 					  "chg-gone",
 					  "usb-valid",
 					  "dc-valid";
+
+			usb-otg-in-supply = <&pm8941_5vs1>;
+
+			chg_otg: otg-vbus { };
 		};
 
 		pm8941_gpios: gpios at c000 {
-- 
2.10.0.297.gf6727b0
