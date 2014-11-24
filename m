From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 24 Nov 2014 14:17:46 +0530
Subject: [PATCH v6 1/2] i2c: s3c2410: add Sysreg phandle to i2c device nodes
In-Reply-To: <1416818867-29156-1-git-send-email-pankaj.dubey@samsung.com>
References: <1416818867-29156-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1416818867-29156-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon based phandle to i2c device nodes of exynos5250
and exynos5420. These phandles will be used to save restore i2c sysreg
configuration register during s2r from i2c driver.

CC: Rob Herring <robh+dt@kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: devicetree at vger.kernel.org
CC: linux-doc at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 .../devicetree/bindings/i2c/i2c-s3c2410.txt        |    1 +
 arch/arm/boot/dts/exynos5250.dtsi                  |    4 ++++
 arch/arm/boot/dts/exynos5420.dtsi                  |    4 ++++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
index 278de8e..89b3250 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
@@ -32,6 +32,7 @@ Optional properties:
     specified, default value is 0.
   - samsung,i2c-max-bus-freq: Desired frequency in Hz of the bus. If not
     specified, the default value in Hz is 100000.
+  - samsung,sysreg-phandle - handle to syscon used to control the system registers
 
 Example:
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 0a588b4..d45a07e 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -293,6 +293,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_bus>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		status = "disabled";
 	};
 
@@ -306,6 +307,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c1_bus>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		status = "disabled";
 	};
 
@@ -319,6 +321,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_bus>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		status = "disabled";
 	};
 
@@ -332,6 +335,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8617a03..90bf401 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -560,6 +560,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_bus>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		status = "disabled";
 	};
 
@@ -573,6 +574,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c1_bus>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		status = "disabled";
 	};
 
@@ -586,6 +588,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_bus>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		status = "disabled";
 	};
 
@@ -599,6 +602,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
+		samsung,sysreg-phandle = <&sysreg_system_controller>;
 		status = "disabled";
 	};
 
-- 
1.7.9.5
