From: nm@ti.com (Nishanth Menon)
Date: Sat, 16 Dec 2017 14:40:39 -0600
Subject: [PATCH V2 7/8] ARM: dts: keystone-k2e-clocks: Add missing unit name
 to clock nodes that have regs
In-Reply-To: <20171216204040.18017-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com> <20171216204040.18017-1-nm@ti.com>
Message-ID: <20171216204040.18017-8-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the control register as the base for the clock nodes which are
missing them. This squashes the following warnings of the effect when built
with W=1:
arch/arm/boot/dts/keystone-k2e-evm.dtb: Warning (unit_address_vs_reg): Node /soc at 0/clocks/clkusb1 has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2e-evm.dtb: Warning (unit_address_vs_reg): Node /soc at 0/clocks/clkhyperlink0 has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2e-evm.dtb: Warning (unit_address_vs_reg): Node /soc at 0/clocks/clkpcie1 has a reg or ranges property, but no unit name
arch/arm/boot/dts/keystone-k2e-evm.dtb: Warning (unit_address_vs_reg): Node /soc at 0/clocks/clkxge has a reg or ranges property, but no unit name

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1: rebase

V1: https://patchwork.kernel.org/patch/10115125/

 arch/arm/boot/dts/keystone-k2e-clocks.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
index 915a99d5bc5e..5e0e7d232161 100644
--- a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
@@ -32,7 +32,7 @@ clocks {
 		reg-names = "control";
 	};
 
-	clkusb1: clkusb1 {
+	clkusb1: clkusb1 at 2350004 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk16>;
@@ -42,7 +42,7 @@ clocks {
 		domain-id = <0>;
 	};
 
-	clkhyperlink0: clkhyperlink0 {
+	clkhyperlink0: clkhyperlink02350030 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;
@@ -52,7 +52,7 @@ clocks {
 		domain-id = <5>;
 	};
 
-	clkpcie1: clkpcie1 {
+	clkpcie1: clkpcie1 at 235006c {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk12>;
@@ -62,7 +62,7 @@ clocks {
 		domain-id = <18>;
 	};
 
-	clkxge: clkxge {
+	clkxge: clkxge at 23500c8 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
-- 
2.14.1
