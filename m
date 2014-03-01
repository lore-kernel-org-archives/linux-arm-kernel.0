From: carlo@caione.org (Carlo Caione)
Date: Sat,  1 Mar 2014 17:45:48 +0100
Subject: [PATCH 3/7] ARM: dts: cubieboard2: Add AXP209 support
In-Reply-To: <1393692352-10839-1-git-send-email-carlo@caione.org>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
Message-ID: <1393692352-10839-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP209 is the PMU used by Cubieboard2. This patch enable the core
support in the dts file.
This patch requires: "ARM: sun7i/sun6i: irqchip: Add irqchip driver for
NMI controller"

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 5c51cb8..234b14b 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -53,6 +53,20 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x at 34 {
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				axp,system-power-controller;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
-- 
1.8.3.2
