From: j.neuschaefer@gmx.net (=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?=)
Date: Sun, 17 Jun 2018 16:31:18 +0200
Subject: [PATCH] dt-bindings: Fix unbalanced quotation marks
Message-ID: <20180617143127.11421-1-j.neuschaefer@gmx.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multiple binding documents have various forms of unbalanced quotation
marks. Fix them.

Signed-off-by: Jonathan Neusch?fer <j.neuschaefer@gmx.net>
---

Should I split this patch so that different parts can go through different trees?
---
 .../devicetree/bindings/arm/samsung/samsung-boards.txt          | 2 +-
 .../devicetree/bindings/gpio/nintendo,hollywood-gpio.txt        | 2 +-
 Documentation/devicetree/bindings/input/touchscreen/hideep.txt  | 2 +-
 .../bindings/interrupt-controller/nvidia,tegra20-ictlr.txt      | 2 +-
 .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt  | 2 +-
 Documentation/devicetree/bindings/mips/brcm/soc.txt             | 2 +-
 Documentation/devicetree/bindings/net/fsl-fman.txt              | 2 +-
 Documentation/devicetree/bindings/power/power_domain.txt        | 2 +-
 Documentation/devicetree/bindings/regulator/tps65090.txt        | 2 +-
 Documentation/devicetree/bindings/reset/st,sti-softreset.txt    | 2 +-
 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt    | 2 +-
 Documentation/devicetree/bindings/sound/qcom,apq8096.txt        | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index bdadc3da9556..6970f30a3770 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -66,7 +66,7 @@ Required root node properties:
 	- "insignal,arndale-octa" - for Exynos5420-based Insignal Arndale
 				    Octa board.
 	- "insignal,origen"       - for Exynos4210-based Insignal Origen board.
-	- "insignal,origen4412    - for Exynos4412-based Insignal Origen board.
+	- "insignal,origen4412"   - for Exynos4412-based Insignal Origen board.
 
 
 Optional nodes:
diff --git a/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt b/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
index 20fc72d9e61e..45a61b462287 100644
--- a/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
@@ -1,7 +1,7 @@
 Nintendo Wii (Hollywood) GPIO controller
 
 Required properties:
-- compatible: "nintendo,hollywood-gpio
+- compatible: "nintendo,hollywood-gpio"
 - reg: Physical base address and length of the controller's registers.
 - gpio-controller: Marks the device node as a GPIO controller.
 - #gpio-cells: Should be <2>. The first cell is the pin number and the
diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
index 121d9b7c79a2..1063c30d53f7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
@@ -32,7 +32,7 @@ i2c at 00000000 {
 		reg = <0x6c>;
 		interrupt-parent = <&gpx1>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&ldo15_reg>";
+		vdd-supply = <&ldo15_reg>;
 		vid-supply = <&ldo18_reg>;
 		reset-gpios = <&gpx1 5 0>;
 		touchscreen-size-x = <1080>;
diff --git a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
index 1099fe0788fa..f246ccbf8838 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra20-ictlr.txt
@@ -15,7 +15,7 @@ Required properties:
   include "nvidia,tegra30-ictlr".	
 - reg : Specifies base physical address and size of the registers.
   Each controller must be described separately (Tegra20 has 4 of them,
-  whereas Tegra30 and later have 5"  
+  whereas Tegra30 and later have 5).
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source. The value must be 3.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
index 136bd612bd83..6a36bf66d932 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
@@ -12,7 +12,7 @@ Required properties:
   specifier, shall be 2
 - interrupts: interrupts references to primary interrupt controller
   (only needed for exti controller with multiple exti under
-  same parent interrupt: st,stm32-exti and st,stm32h7-exti")
+  same parent interrupt: st,stm32-exti and st,stm32h7-exti)
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index 356c29789cf5..3a66d3c483e1 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -152,7 +152,7 @@ Required properties:
 - compatible	: should contain one of:
 		  "brcm,bcm7425-timers"
 		  "brcm,bcm7429-timers"
-		  "brcm,bcm7435-timers and
+		  "brcm,bcm7435-timers" and
 		  "brcm,brcmstb-timers"
 - reg		: the timers register range
 - interrupts	: the interrupt line for this timer block
diff --git a/Documentation/devicetree/bindings/net/fsl-fman.txt b/Documentation/devicetree/bindings/net/fsl-fman.txt
index df873d1f3b7c..f8c33890bc29 100644
--- a/Documentation/devicetree/bindings/net/fsl-fman.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fman.txt
@@ -238,7 +238,7 @@ PROPERTIES
 		Must include one of the following:
 		- "fsl,fman-dtsec" for dTSEC MAC
 		- "fsl,fman-xgec" for XGEC MAC
-		- "fsl,fman-memac for mEMAC MAC
+		- "fsl,fman-memac" for mEMAC MAC
 
 - cell-index
 		Usage: required
diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 9b387f861aed..7dec508987c7 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -133,7 +133,7 @@ located inside a PM domain with index 0 of a power controller represented by a
 node with the label "power".
 In the second example the consumer device are partitioned across two PM domains,
 the first with index 0 and the second with index 1, of a power controller that
-is represented by a node with the label "power.
+is represented by a node with the label "power".
 
 Optional properties:
 - required-opps: This contains phandle to an OPP node in another device's OPP
diff --git a/Documentation/devicetree/bindings/regulator/tps65090.txt b/Documentation/devicetree/bindings/regulator/tps65090.txt
index ca69f5e3040c..ae326f263597 100644
--- a/Documentation/devicetree/bindings/regulator/tps65090.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65090.txt
@@ -16,7 +16,7 @@ Required properties:
 Optional properties:
 - ti,enable-ext-control: This is applicable for DCDC1, DCDC2 and DCDC3.
   If DCDCs are externally controlled then this property should be there.
-- "dcdc-ext-control-gpios: This is applicable for DCDC1, DCDC2 and DCDC3.
+- dcdc-ext-control-gpios: This is applicable for DCDC1, DCDC2 and DCDC3.
   If DCDCs are externally controlled and if it is from GPIO then GPIO
   number should be provided. If it is externally controlled and no GPIO
   entry then driver will just configure this rails as external control
diff --git a/Documentation/devicetree/bindings/reset/st,sti-softreset.txt b/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
index a21658f18fe6..3661e6153a92 100644
--- a/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
+++ b/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
@@ -15,7 +15,7 @@ Please refer to reset.txt in this directory for common reset
 controller binding usage.
 
 Required properties:
-- compatible: Should be st,stih407-softreset";
+- compatible: Should be "st,stih407-softreset";
 - #reset-cells: 1, see below
 
 example:
diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
index 6a4aadc4ce06..84b28dbe9f15 100644
--- a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
@@ -30,7 +30,7 @@ Required properties:
 
 			  Board connectors:
 			  * Headset Mic
-			  * Secondary Mic",
+			  * Secondary Mic
 			  * DMIC
 			  * Ext Spk
 
diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
index aa54e49fc8a2..c7600a93ab39 100644
--- a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -35,7 +35,7 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
 			"Digital Mic3"
 
 		Audio pins and MicBias on WCD9335 Codec:
-			"MIC_BIAS1
+			"MIC_BIAS1"
 			"MIC_BIAS2"
 			"MIC_BIAS3"
 			"MIC_BIAS4"
-- 
2.17.1
