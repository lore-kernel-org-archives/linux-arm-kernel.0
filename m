From: megous@megous.com (megous at megous.com)
Date: Sun, 17 Dec 2017 02:27:21 +0100
Subject: [PATCH] ARM: dts: sun8i-a83t-tbs-a711: Add missing axp813 compatible
Message-ID: <20171217012721.5923-1-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Without this the AXP813 PMIC fails to probe on TBS A711.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index e6b00b3774e3..76be9d43f906 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -479,6 +479,7 @@
 	status = "okay";
 
 	axp81x: pmic at 3a3 {
+		compatible = "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-- 
2.15.1
