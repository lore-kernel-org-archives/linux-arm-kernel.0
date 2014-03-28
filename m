From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Fri, 28 Mar 2014 18:59:07 +0100
Subject: [RFC PATCH v2 09/10] ARM: at91/dt: add new AIC irq mux definitions
 for sam9x5 SoCs
In-Reply-To: <1396029548-10928-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1396029548-10928-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1396029548-10928-10-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq line muxing definition for sam9x5 SoCs.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |  108 +++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 174219d..ccdfdf3 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -69,6 +69,114 @@
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
 				atmel,external-irqs = <31>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				ranges = <1 0x0 0xffffc000 0x4000>,
+					 <2 0x0 0xfffff400 0x400>,
+					 <3 0x0 0xfffff800 0x400>,
+					 <17 0x0 0xf8008000 0x8000>;
+
+				dbgu_irq: irq-mux at 1,2e0c {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <1 0x2e0c 0x4>;
+					atmel,aic-mux-reg-mask = <0xc00002e3>;
+				};
+
+				pmc_irq: irq-mux at 1,3c64 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <1 0x3c64 0x4>;
+					atmel,aic-mux-reg-mask = <0x7034b>;
+				};
+
+				pmecc_irq: irq-mux at 1,2020 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <1 0x2020 0x4>;
+					atmel,aic-mux-reg-mask = <0x1>;
+				};
+
+				pmerrloc_irq: irq-mux at 1,2618 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <1 0x2618 0x4>;
+					atmel,aic-mux-reg-mask = <0x1>;
+				};
+
+				pit_irq: irq-mux at 1,3e30 {
+					compatible = "atmel,aic-mux-1reg-irq";
+					reg = <1 0x3e30 0x4>;
+					atmel,aic-mux-reg-mask = <0x2000000>;
+				};
+
+				wdt_irq: irq-mux at 1,3e40 {
+					compatible = "atmel,aic-mux-1reg-irq";
+					reg = <1 0x3e40 0x4>;
+					atmel,aic-mux-reg-mask = <0x1000>;
+				};
+
+				rtc_irq: irq-mux at 1,3ed4 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <1 0x3ed4 0x4>;
+					atmel,aic-mux-reg-mask = <0x1f>;
+				};
+
+				pioA_irq: irq-mux at 2,44 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <2 0x44 0x4>;
+					atmel,aic-mux-reg-mask = <0xffffffff>;
+				};
+
+				pioB_irq: irq-mux at 2,244 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <2 0x244 0x4>;
+					atmel,aic-mux-reg-mask = <0xffffffff>;
+				};
+
+				pioC_irq: irq-mux at 3,44 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <3 0x44 0x4>;
+					atmel,aic-mux-reg-mask = <0xffffffff>;
+				};
+
+				pioD_irq: irq-mux at 3,244 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <3 0x244 0x4>;
+					atmel,aic-mux-reg-mask = <0xffffffff>;
+				};
+
+				tc0_irq: irq-mux at 17,28 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <17 0x28 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc1_irq: irq-mux at 17,68 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <17 0x68 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc2_irq: irq-mux at 17,a8 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <17 0xa8 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc3_irq: irq-mux at 17,4028 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <17 0x4028 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc4_irq: irq-mux at 17,4068 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <17 0x4068 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
+
+				tc5_irq: irq-mux at 17,40a8 {
+					compatible = "atmel,aic-mux-3reg-irq";
+					reg = <17 0x40a8 0x4>;
+					atmel,aic-mux-reg-mask = <0xff>;
+				};
 			};
 
 			ramc0: ramc at ffffe800 {
-- 
1.7.9.5
