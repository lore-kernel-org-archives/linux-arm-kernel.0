From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 13:05:00 +0000
Subject: [PATCH 04/10] ARM: ux500: split dts file for snowball into generic
 part
In-Reply-To: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1331730306-11461-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

db8500.dtsi can be used by all systems with a db8500 or
db9500 SoC, while snowball.dts is board specific.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi  |   21 +++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts |    8 +-------
 2 files changed, 22 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/db8500.dtsi

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
new file mode 100644
index 0000000..50c84b2
--- /dev/null
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -0,0 +1,21 @@
+/*
+ * Copyright 2012 Linaro Ltd
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	soc-u9500 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+	};
+};
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index ebcff9a..0ea9470 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -10,22 +10,16 @@
  */
 
 /dts-v1/;
+/include/ "db8500.dtsi"
 
 / {
 	model = "Calao Systems Snowball platform with device tree";
 	compatible = "calaosystems,snowball-a9500";
 
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	memory {
 		reg = <0x00000000 0x20000000>;
 	};
 
 	soc-u9500 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		ranges;
 	};
 };
-- 
1.7.5.4
