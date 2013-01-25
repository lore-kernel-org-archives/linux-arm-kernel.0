From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 25 Jan 2013 16:48:44 +0530
Subject: [PATCH] ARM: davinci: da850: add interrupt-parent property in soc node
Message-ID: <1359112724-1217-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.lad@ti.com>

This patch adds 'interrupt-parent' property in soc node, so that
the child inherits this property, this avoids adding 'interrupt-parent'
to each node.

Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: devicetree-discuss at lists.ozlabs.org
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Heiko Schocher <hs@denx.de>
---
 arch/arm/boot/dts/da850.dtsi |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 2551098..7c84822 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -28,6 +28,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x01c00000 0x400000>;
+		interrupt-parent = <&intc>;
 
 		pmx_core: pinmux at 1c14120 {
 			compatible = "pinctrl-single";
@@ -62,7 +63,6 @@
 			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <25>;
-			interrupt-parent = <&intc>;
 			status = "disabled";
 		};
 		serial1: serial at 1d0c000 {
@@ -71,7 +71,6 @@
 			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <53>;
-			interrupt-parent = <&intc>;
 			status = "disabled";
 		};
 		serial2: serial at 1d0d000 {
@@ -80,7 +79,6 @@
 			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <61>;
-			interrupt-parent = <&intc>;
 			status = "disabled";
 		};
 	};
-- 
1.7.4.1
