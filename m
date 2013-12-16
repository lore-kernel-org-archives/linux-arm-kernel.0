From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon, 16 Dec 2013 21:24:20 +0100
Subject: [RFC PATCH 09/10] ARM: at91/dt: add new AIC irq mux definitions
In-Reply-To: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
References: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1387225461-6201-10-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq line muxing definition for sam9x5 SoCs.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |  111 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 40267a1..619e24a 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -68,6 +68,113 @@
 				interrupt-controller;
 				reg = <0xfffff000 0x200>;
 				atmel,external-irqs = <31>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				sysc_irq_mux: irq-mux at 1 {
+					compatible = "atmel,aic-mux";
+					reg = <1>;
+
+					dbgu_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&dbgu 0 0xc 0xc00002e3>;
+					};
+
+					pmc_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&pmc 0 0x64 0x7034b>;
+					};
+
+					pmecc_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&nand0 1 0x20 0x1>;
+					};
+
+					pmerrloc_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&nand0 2 0x18 0x1>;
+					};
+
+					pit_irq {
+						compatible = "atmel,aic-mux-1reg-irq";
+						atmel,aic-mux-irq-reg = <&pit 0 0x0 0x2000000>;
+					};
+
+					wdt_irq {
+						compatible = "atmel,aic-mux-1reg-irq";
+						atmel,aic-mux-irq-reg = <&wdt 0 0x4 0x1000>;
+					};
+
+					rtc_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&rtc 0 0x24 0x1f>;
+					};
+				};
+
+				pioAB_irq_mux: irq-mux at 2 {
+					compatible = "atmel,aic-mux";
+					reg = <2>;
+
+					pioA_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&pioA 0 0x44 0xffffffff>;
+					};
+
+					pioB_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&pioB 0 0x44 0xffffffff>;
+					};
+				};
+
+				pioCD_irq_mux: irq-mux at 3 {
+					compatible = "atmel,aic-mux";
+					reg = <3>;
+
+					pioC_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&pioC 0 0x44 0xffffffff>;
+					};
+
+					pioD_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&pioD 0 0x44 0xffffffff>;
+					};
+				};
+
+				tcb_irq_mux: irq-mux at 17 {
+					compatible = "atmel,aic-mux";
+					reg = <17>;
+
+					tc0_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&tcb0 0 0x28 0xff>;
+					};
+
+					tc1_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&tcb0 0 0x68 0xff>;
+					};
+
+					tc2_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&tcb0 0 0xa8 0xff>;
+					};
+
+					tc3_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&tcb1 0 0x28 0xff>;
+					};
+
+					tc4_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&tcb1 0 0x68 0xff>;
+					};
+
+					tc5_irq {
+						compatible = "atmel,aic-mux-3reg-irq";
+						atmel,aic-mux-irq-reg = <&tcb1 0 0xa8 0xff>;
+					};
+				};
 			};
 
 			ramc0: ramc at ffffe800 {
@@ -750,13 +857,13 @@
 				};
 			};
 
-			watchdog at fffffe40 {
+			wdt: watchdog at fffffe40 {
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
 				status = "disabled";
 			};
 
-			rtc at fffffeb0 {
+			rtc: rtc at fffffeb0 {
 				compatible = "atmel,at91sam9x5-rtc";
 				reg = <0xfffffeb0 0x40>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-- 
1.7.9.5
