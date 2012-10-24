From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Wed, 24 Oct 2012 09:07:13 +0200
Subject: [PATCH v3 3/4] ARM: dts: omap5: Update UART with address space and
 interrupts
In-Reply-To: <1351062434-22514-1-git-send-email-s-guiriec@ti.com>
References: <1351062434-22514-1-git-send-email-s-guiriec@ti.com>
Message-ID: <1351062434-22514-4-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add base address and interrupt line inside Device Tree data for
OMAP5.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 07d2607..b535d8e 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -250,36 +250,54 @@
 
 		uart1: serial at 4806a000 {
 			compatible = "ti,omap4-uart";
+			reg = <0x4806a000 0x100>;
+			interrupts = <0 72 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
 		uart2: serial at 4806c000 {
 			compatible = "ti,omap4-uart";
+			reg = <0x4806c000 0x100>;
+			interrupts = <0 73 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
 		uart3: serial at 48020000 {
 			compatible = "ti,omap4-uart";
+			reg = <0x48020000 0x100>;
+			interrupts = <0 74 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
 		uart4: serial at 4806e000 {
 			compatible = "ti,omap4-uart";
+			reg = <0x4806e000 0x100>;
+			interrupts = <0 70 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
 
 		uart5: serial at 48066000 {
-			compatible = "ti,omap5-uart";
+			compatible = "ti,omap4-uart";
+			reg = <0x48066000 0x100>;
+			interrupts = <0 105 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 		};
 
 		uart6: serial at 48068000 {
-			compatible = "ti,omap6-uart";
+			compatible = "ti,omap4-uart";
+			reg = <0x48068000 0x100>;
+			interrupts = <0 106 0x4>;
+			interrupt-parent = <&gic>;
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 		};
-- 
1.7.10.4
