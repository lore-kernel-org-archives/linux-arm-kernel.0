From: tony.xie@rock-chips.com (Tony Xie)
Date: Tue, 31 Jul 2018 15:57:28 +0800
Subject: [PATCH v2 3/5] dt-bindings: mfd: rk808: Add binding informations for
 RK809 and RK817.
In-Reply-To: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
Message-ID: <1533023850-29004-4-git-send-email-tony.xie@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
---
 Documentation/devicetree/bindings/mfd/rk808.txt | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 91b6522..31c9f3d 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -3,11 +3,15 @@ RK8XX Power Management Integrated Circuit
 The rk8xx family current members:
 rk805
 rk808
+rk809
+rk817
 rk818
 
 Required properties:
 - compatible: "rockchip,rk805"
 - compatible: "rockchip,rk808"
+- compatible: "rockchip,rk809"
+- compatible: "rockchip,rk817"
 - compatible: "rockchip,rk818"
 - reg: I2C slave address
 - interrupt-parent: The parent interrupt controller.
@@ -46,6 +50,28 @@ Optional RK808 properties:
   the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
   very quickly with no slow ramp time.
 
+Optional RK809 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
+- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
+- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
+- vcc8-supply:  The input supply for SWITCH_REG1
+- vcc9-supply:  The input supply for DCDC_REG5, SWITCH_REG2
+
+Optional RK817 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
+- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
+- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
+- vcc8-supply:  The input supply for BOOST
+- vcc9-supply:  The input supply for OTG_SWITCH
+
 Optional RK818 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -87,6 +113,28 @@ number as described in RK808 datasheet.
 	- SWITCH_REGn
 		- valid values for n are 1 to 2
 
+Following regulators of the RK809 PMIC block are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK808 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 5.
+	- LDO_REGn
+		- valid values for n are 1 to 9.
+	- SWITCH_REGn
+		- valid values for n are 1 to 2.
+
+Following regulators of the RK817 PMIC block are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK818 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 4.
+	- LDO_REGn
+		- valid values for n are 1 to 9.
+	- BOOST
+	- OTG_SWITCH
+
 Following regulators of the RK818 PMIC block are supported. Note that
 the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
 number as described in RK818 datasheet.
@@ -99,6 +147,13 @@ number as described in RK818 datasheet.
 	- HDMI_SWITCH
 	- OTG_SWITCH
 
+There are three pins needed to config, named "gpio_ts" "gpio_gt" "gpio_slp".
+	The gpio_gt and gpio_ts pins support the gpio function.
+	The gpio_slp pin is for controlling the pmic states, as below:
+		- reset
+		- power down
+		- sleep
+
 Standard regulator bindings are used inside regulator subnodes. Check
   Documentation/devicetree/bindings/regulator/regulator.txt
 for more details
-- 
1.9.1
