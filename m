From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 15 May 2012 19:50:39 +0530
Subject: [PATCH v2 18/20] ARM: dts: Update device tree source files for
 EXYNOS5250
In-Reply-To: <CAJuYYwTws16QQzimAp4c1T33nW4XapOLtE8mL8p=aRfRp8V28A@mail.gmail.com>
References: <CAJuYYwTws16QQzimAp4c1T33nW4XapOLtE8mL8p=aRfRp8V28A@mail.gmail.com>
Message-ID: <1337091639-15912-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update EXYNOS5 device tree source files to reflect changes in rev1
of EXYNOS5 SoC. This includes new additions to the EXYNOS5 dtsi and
SMDK5250 dts files and few minor fixes.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   48 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   60 ++++++++++++++---------------
 2 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 399d17b..49945cc 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -23,4 +23,52 @@
 	chosen {
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 console=ttySAC1,115200";
 	};
+
+	i2c at 12C60000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <20000>;
+		gpios = <&gpb3 0 2 3 0>,
+			<&gpb3 1 2 3 0>;
+
+		eeprom at 50 {
+			compatible = "samsung,s524ad0xd1";
+			reg = <0x50>;
+		};
+	};
+
+	i2c at 12C70000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <20000>;
+		gpios = <&gpb3 2 2 3 0>,
+			<&gpb3 3 2 3 0>;
+
+		eeprom at 51 {
+			compatible = "samsung,s524ad0xd1";
+			reg = <0x51>;
+		};
+	};
+
+	i2c at 12C80000 {
+		status = "disabled";
+	};
+
+	i2c at 12C90000 {
+		status = "disabled";
+	};
+
+	i2c at 12CA0000 {
+		status = "disabled";
+	};
+
+	i2c at 12CB0000 {
+		status = "disabled";
+	};
+
+	i2c at 12CC0000 {
+		status = "disabled";
+	};
+
+	i2c at 12CD0000 {
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index dfc4335..5ca0cdb 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -23,11 +23,11 @@
 	compatible = "samsung,exynos5250";
 	interrupt-parent = <&gic>;
 
-	gic:interrupt-controller at 10490000 {
+	gic:interrupt-controller at 10481000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
+		reg = <0x10481000 0x1000>, <0x10482000 0x2000>;
 	};
 
 	watchdog {
@@ -42,30 +42,6 @@
 		interrupts = <0 43 0>, <0 44 0>;
 	};
 
-	sdhci at 12200000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12200000 0x100>;
-		interrupts = <0 75 0>;
-	};
-
-	sdhci at 12210000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12210000 0x100>;
-		interrupts = <0 76 0>;
-	};
-
-	sdhci at 12220000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12220000 0x100>;
-		interrupts = <0 77 0>;
-	};
-
-	sdhci at 12230000 {
-		compatible = "samsung,exynos4210-sdhci";
-		reg = <0x12230000 0x100>;
-		interrupts = <0 78 0>;
-	};
-
 	serial at 12C00000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C00000 0x100>;
@@ -94,48 +70,64 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C60000 0x100>;
 		interrupts = <0 56 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 12C70000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C70000 0x100>;
 		interrupts = <0 57 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 12C80000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C80000 0x100>;
 		interrupts = <0 58 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 12C90000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C90000 0x100>;
 		interrupts = <0 59 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 12CA0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CA0000 0x100>;
 		interrupts = <0 60 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 12CB0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CB0000 0x100>;
 		interrupts = <0 61 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 12CC0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CC0000 0x100>;
 		interrupts = <0 62 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	i2c at 12CD0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CD0000 0x100>;
 		interrupts = <0 63 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
 	amba {
@@ -157,13 +149,13 @@
 			interrupts = <0 35 0>;
 		};
 
-		mdma0: pdma at 10800000 {
+		mdma0: mdma at 10800000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10800000 0x1000>;
 			interrupts = <0 33 0>;
 		};
 
-		mdma1: pdma at 11C10000 {
+		mdma1: mdma at 11C10000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x11C10000 0x1000>;
 			interrupts = <0 124 0>;
@@ -242,6 +234,12 @@
 			#gpio-cells = <4>;
 		};
 
+		gpc4: gpio-controller at 114002E0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114002E0 0x20>;
+			#gpio-cells = <4>;
+		};
+
 		gpd0: gpio-controller at 11400160 {
 			compatible = "samsung,exynos4-gpio";
 			reg = <0x11400160 0x20>;
@@ -388,19 +386,19 @@
 
 		gpv2: gpio-controller at 10D10040 {
 			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10040 0x20>;
+			reg = <0x10D10060 0x20>;
 			#gpio-cells = <4>;
 		};
 
 		gpv3: gpio-controller at 10D10060 {
 			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10060 0x20>;
+			reg = <0x10D10080 0x20>;
 			#gpio-cells = <4>;
 		};
 
 		gpv4: gpio-controller at 10D10080 {
 			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10080 0x20>;
+			reg = <0x10D100C0 0x20>;
 			#gpio-cells = <4>;
 		};
 
-- 
1.6.6.rc2
