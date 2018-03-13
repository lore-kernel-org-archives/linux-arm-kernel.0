From: ctatlor97@gmail.com (Craig Tatlor)
Date: Tue, 13 Mar 2018 16:46:38 +0000
Subject: [PATCH v2] ARM: dts: msm8974: castor: Fix typo and add startup delay
 in touchscreen node
In-Reply-To: <20180312160734.5606-1-ctatlor97@gmail.com>
References: <20180312160734.5606-1-ctatlor97@gmail.com>
Message-ID: <20180313164638.7211-1-ctatlor97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string was mistakenly pulled from the downstream tree and the
startup delay property is needed to prevent io errors on initial page select.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
index e87f2c99060d..701b396719c7 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
@@ -491,7 +491,7 @@
 		pinctrl-0 = <&i2c8_pins>;
 
 		synaptics at 2c {
-			compatible = "syna,rmi-i2c";
+			compatible = "syna,rmi4-i2c";
 			reg = <0x2c>;
 
 			interrupt-parent = <&msmgpio>;
@@ -506,6 +506,8 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&ts_int_pin>;
 
+			syna,startup-delay-ms = <10>;
+
 			rmi-f01 at 1 {
 				reg = <0x1>;
 				syna,nosleep = <1>;
-- 
2.16.1
