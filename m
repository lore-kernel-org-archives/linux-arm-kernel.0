From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:49 +0200
Subject: [PATCH v3 07/12] ARM: dts: sun8i: a711: include axp81x dtsi
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-8-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has an AXP813 PMIC so let's include its dtsi.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 723641f56a74..4f4db07ca19f 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -146,7 +146,7 @@
 &r_rsb {
 	status = "okay";
 
-	axp813: pmic at 3a3 {
+	axp81x: pmic at 3a3 {
 		compatible = "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
@@ -179,6 +179,8 @@
 
 };
 
+#include "axp81x.dtsi"
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.11.0
