From: carlo.caione@gmail.com (Carlo Caione)
Date: Mon,  6 Jan 2014 18:41:36 +0100
Subject: [PATCH v2 2/3] ARM: sun7i: dts: Add NMI irqchip support
In-Reply-To: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
Message-ID: <1389030097-10822-3-git-send-email-carlo.caione@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DTS entry for NMI controller as child of GIC.

Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4c25f81..89e93da 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -310,6 +310,15 @@
 		#size-cells = <1>;
 		ranges;
 
+		nmi_intc: sc-nmi-intc at 01c00030 {
+			compatible = "allwinner,sun7i-sc-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01c00030 0x0c>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 0 1>;
+		};
+
 		emac: ethernet at 01c0b000 {
 			compatible = "allwinner,sun4i-emac";
 			reg = <0x01c0b000 0x1000>;
-- 
1.8.5.2
