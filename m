From: carlo@caione.org (Carlo Caione)
Date: Wed,  5 Mar 2014 20:45:30 +0100
Subject: [PATCH v5 2/3] ARM: sun7i/sun6i: dts: Add NMI irqchip support
In-Reply-To: <1394048731-4570-1-git-send-email-carlo@caione.org>
References: <1394048731-4570-1-git-send-email-carlo@caione.org>
Message-ID: <1394048731-4570-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DTS entries for NMI controller as child of GIC.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 9 +++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..4a5050c 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -190,6 +190,15 @@
 		#size-cells = <1>;
 		ranges;
 
+		nmi_intc: sc-nmi-intc at 01f00c0c {
+			compatible = "allwinner,sun6i-a31-sc-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01f00c0c 0x38>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 0 4>;
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun6i-a31-pinctrl";
 			reg = <0x01c20800 0x400>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4c25f81..f01a23c 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -310,6 +310,15 @@
 		#size-cells = <1>;
 		ranges;
 
+		nmi_intc: sc-nmi-intc at 01c00030 {
+			compatible = "allwinner,sun7i-a20-sc-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01c00030 0x0c>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 0 4>;
+		};
+
 		emac: ethernet at 01c0b000 {
 			compatible = "allwinner,sun4i-emac";
 			reg = <0x01c0b000 0x1000>;
-- 
1.8.3.2
