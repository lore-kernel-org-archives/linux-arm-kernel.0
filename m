From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Apr 2018 10:46:12 -0300
Subject: [PATCH 3/5] ARM: dts: imx: Remove #address/#size-cells from switch
 nodes
In-Reply-To: <1524491174-16878-1-git-send-email-festevam@gmail.com>
References: <1524491174-16878-1-git-send-email-festevam@gmail.com>
Message-ID: <1524491174-16878-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells from the switch nodes
to fix the following DTC warnings:

arch/arm/boot/dts/imx6q-b450v3.dtb: Warning (avoid_unnecessary_addr_size): /mdio-gpio/switch at 0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts      | 2 --
 arch/arm/boot/dts/imx6q-bx50v3.dtsi       | 2 --
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi     | 2 --
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi   | 2 --
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 6 ------
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 4 ----
 6 files changed, 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 0c99ac0..991fa07 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -207,8 +207,6 @@
 
 		switch at 0 {
 			compatible = "marvell,mv88e6085";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0>;
 			dsa,member = <0 0>;
 
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index 990e411..d0e7dab 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -107,8 +107,6 @@
 
 		switch at 0 {
 			compatible = "marvell,mv88e6085"; /* 88e6240*/
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0>;
 
 			switch_ports: ports {
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 58124ad..3c52bdb 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -162,8 +162,6 @@
 
 		switch at 0 {
 			compatible = "marvell,mv88e6085";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0>;
 
 			ports {
diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 911f7f0..0c6482a 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -666,8 +666,6 @@
 			compatible = "marvell,mv88e6085";
 			pinctrl-0 = <&pinctrl_switch_irq>;
 			pinctrl-names = "default";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0>;
 			dsa,member = <0 0>;
 			eeprom-length = <512>;
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 782b69a..bd79e00 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -70,8 +70,6 @@
 				compatible = "marvell,mv88e6085";
 				pinctrl-0 = <&pinctrl_gpio_switch0>;
 				pinctrl-names = "default";
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 0>;
 				interrupt-parent = <&gpio0>;
@@ -156,8 +154,6 @@
 				compatible = "marvell,mv88e6085";
 				pinctrl-0 = <&pinctrl_gpio_switch1>;
 				pinctrl-names = "default";
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 1>;
 				interrupt-parent = <&gpio0>;
@@ -243,8 +239,6 @@
 
 			switch2: switch at 0 {
 				compatible = "marvell,mv88e6085";
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 2>;
 
diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index c6f134c..0b1e94c 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -69,8 +69,6 @@
 				compatible = "marvell,mv88e6190";
 				pinctrl-0 = <&pinctrl_gpio_switch0>;
 				pinctrl-names = "default";
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 0>;
 				eeprom-length = <65536>;
@@ -166,8 +164,6 @@
 				compatible = "marvell,mv88e6190";
 				pinctrl-0 = <&pinctrl_gpio_switch1>;
 				pinctrl-names = "default";
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <0>;
 				dsa,member = <0 1>;
 				eeprom-length = <65536>;
-- 
2.7.4
