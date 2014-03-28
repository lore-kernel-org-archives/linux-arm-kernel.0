From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Fri, 28 Mar 2014 18:59:08 +0100
Subject: [RFC PATCH v2 10/10] ARM: at91/dt: add new AIC irq mux definitions
 for sama5 SoCs
In-Reply-To: <1396029548-10928-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1396029548-10928-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1396029548-10928-11-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq line muxing definition for sama5 SoCs.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 arch/arm/boot/dts/sama5d3.dtsi      |   37 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sama5d3_tcb1.dtsi |   20 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 3d5faf8..ece1f7b 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -416,6 +416,43 @@
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
 				atmel,external-irqs = <47>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges = <1 0x0 0xffffc000 0x4000>,
+					 <26 0x0 0xf0010000 0x4000>,
+					 <27 0x0 0xf8014000 0x4000>;
+
+				atmel,aic-irq-mapping = <0xffffffff 0x7ffff>;
+
+				pmc_irq: irq-mux at 1,3c64 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <1 0x3c64 0x4>;
+					atmel,aic-mux-reg-mask = <0x5074b>;
+				};
+
+				rtc_irq: irq-mux at 1,3ed4 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <1 0x3ed4 0x4>;
+					atmel,aic-mux-reg-mask = <0x1f>;
+				};
+
+				tc0_irq: irq-mux at 26,28 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <26 0x28 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc1_irq: irq-mux at 26,68 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <26 0x68 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc2_irq: irq-mux at 26,a8 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <26 0xa8 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
 			};
 
 			pinctrl at fffff200 {
diff --git a/arch/arm/boot/dts/sama5d3_tcb1.dtsi b/arch/arm/boot/dts/sama5d3_tcb1.dtsi
index 382b044..6060bfd 100644
--- a/arch/arm/boot/dts/sama5d3_tcb1.dtsi
+++ b/arch/arm/boot/dts/sama5d3_tcb1.dtsi
@@ -18,6 +18,26 @@
 
 	ahb {
 		apb {
+			aic: interrupt-controller at fffff000 {
+				tc3_irq: irq-mux at 27,28 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <27 0x28 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc4_irq: irq-mux at 27,68 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <27 0x68 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc5_irq: irq-mux at 27,a8 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <27 0xa8 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+			};
+
 			pmc: pmc at fffffc00 {
 				periphck {
 					tcb1_clk: tcb1_clk {
-- 
1.7.9.5
