From: nm@ti.com (Nishanth Menon)
Date: Wed, 9 Oct 2013 18:24:50 -0500
Subject: [PATCH V6 07/15] ARM: dts: omap5-uevm: add smps123 supply for CPU
In-Reply-To: <1381361098-8283-1-git-send-email-nm@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361098-8283-1-git-send-email-nm@ti.com>
Message-ID: <1381361098-8283-6-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regulator smps123 supply from Palmas PMIC powers CPU0 on OMAP5uEVM.

Based on a patch by J Keerthy <j-keerthy@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |    4 ++++
 arch/arm/boot/dts/omap5.dtsi     |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index d784b3a..3188511 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -503,3 +503,7 @@
         pinctrl-names = "default";
         pinctrl-0 = <&uart5_pins>;
 };
+
+&cpu0 {
+	cpu0-supply = <&smps123_reg>;
+};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 86295d2..2e83e24 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -33,7 +33,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
-- 
1.7.9.5
