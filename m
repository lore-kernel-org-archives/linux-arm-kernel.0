From: nm@ti.com (Nishanth Menon)
Date: Wed, 8 May 2013 14:06:13 -0500
Subject: [PATCH V5 3/6] ARM: dts: OMAP4: add clock nodes for CPU
In-Reply-To: <1368039976-29648-1-git-send-email-nm@ti.com>
References: <1368039976-29648-1-git-send-email-nm@ti.com>
Message-ID: <1368039976-29648-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP443x, OMAP446x and OMAP447x platforms use dpll_mpu clock.
Add same to common definition.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
no change in current revision.
Previous version: http://marc.info/?l=linux-kernel&m=136580751024225&w=2

 arch/arm/boot/dts/omap4.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2a56428..1c6d969 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -31,6 +31,8 @@
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
+			clocks = <&dpll_mpu>;
+			clock-names = "cpu";
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
@@ -106,6 +108,11 @@
 			ti,hwmods = "counter_32k";
 		};
 
+		dpll_mpu: dpll_mpu {
+			#clock-cells = <0>;
+			compatible = "ti,omap-clock";
+		};
+
 		omap4_pmx_core: pinmux at 4a100040 {
 			compatible = "ti,omap4-padconf", "pinctrl-single";
 			reg = <0x4a100040 0x0196>;
-- 
1.7.9.5
