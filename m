From: w.egorov@phytec.de (Wadim Egorov)
Date: Fri, 15 Apr 2016 11:16:30 +0200
Subject: [PATCH 6/6] mfd: dt-bindings: Add RK818 device tree bindings document
In-Reply-To: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1460711790-22646-7-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings documentation for Rockchip's RK818 PMIC.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
Changes since RFC:
* fixed names and wildcards
---
 Documentation/devicetree/bindings/mfd/rk808.txt | 37 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 4ca6aab..5a01d51 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -1,7 +1,11 @@
-RK808 Power Management Integrated Circuit
+RK8XX Power Management Integrated Circuit
+
+The rk8xx family current members:
+rk808
+rk818
 
 Required properties:
-- compatible: "rockchip,rk808"
+- compatible: "rockchip,rk808", "rockchip,rk818"
 - reg: I2C slave address
 - interrupt-parent: The parent interrupt controller.
 - interrupts: the interrupt outputs of the controller.
@@ -13,6 +17,8 @@ Optional properties:
   default output clock name
 - rockchip,system-power-controller: Telling whether or not this pmic is controlling
   the system power.
+
+Optional RK808 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
 - vcc3-supply:  The input supply for DCDC_REG3
@@ -29,7 +35,20 @@ Optional properties:
   the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
   very quickly with no slow ramp time.
 
-Regulators: All the regulators of RK808 to be instantiated shall be
+Optional RK818 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- boost-supply: The input supply for DCDC_BOOST
+- vcc6-supply:  The input supply for LDO_REG1 and LDO_REG2
+- vcc7-supply:  The input supply for LDO_REG3, LDO_REG5 and LDO_REG7
+- vcc8-supply:  The input supply for LDO_REG4, LDO_REG6 and LDO_REG8
+- vcc9-supply:  The input supply for LDO_REG9 and SWITCH_REG
+- h_5v-supply:  The input supply for HDMI_SWITCH
+- usb-supply:   The input supply for OTG_SWITCH
+
+Regulators: All the regulators of RK8xx to be instantiated shall be
 listed in a child node named 'regulators'. Each regulator is represented
 by a child node of the 'regulators' node.
 
@@ -48,6 +67,18 @@ number as described in RK808 datasheet.
 	- SWITCH_REGn
 		- valid values for n are 1 to 2
 
+Following regulators of the RK818 PMIC block are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK818 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 4.
+	- LDO_REGn
+		- valid values for n are 1 to 9.
+	- SWITCH_REG
+	- HDMI_SWITCH
+	- OTG_SWITCH
+
 Standard regulator bindings are used inside regulator subnodes. Check
   Documentation/devicetree/bindings/regulator/regulator.txt
 for more details
-- 
1.9.1
