From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 20 May 2014 17:10:46 +0200
Subject: [PATCH] ARM: dts: exynos4: Remove custom fixed rate clock nodes
Message-ID: <1400598646-7420-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch specifies the XXTI and XUSBXTI clock sources as standard
fixed rate clocks and removes the related Exynos custom clock nodes.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                  |   14 +++++++++++++-
 arch/arm/boot/dts/exynos4210-origen.dts         |   12 ------------
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |   16 ++++------------
 arch/arm/boot/dts/exynos4210-trats.dts          |   12 ------------
 arch/arm/boot/dts/exynos4210-universal_c210.dts |   12 ------------
 arch/arm/boot/dts/exynos4210.dtsi               |    2 ++
 arch/arm/boot/dts/exynos4412-origen.dts         |   12 ------------
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |   12 ------------
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |   12 ------------
 arch/arm/boot/dts/exynos4412-trats2.dts         |   12 ------------
 arch/arm/boot/dts/exynos4x12.dtsi               |    2 ++
 11 files changed, 21 insertions(+), 97 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e8a4e20..d91792d 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -46,6 +46,18 @@
 		fimc3 = &fimc_3;
 	};

+	xxti: xxti {
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		#clock-cells = <0>;
+	};
+
+	xusbxti: xusbxti {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		#clock-cells = <0>;
+	};
+
 	clock_audss: clock-controller at 03810000 {
 		compatible = "samsung,exynos4210-audss-clock";
 		reg = <0x03810000 0x0C>;
@@ -305,7 +317,7 @@
 		compatible = "samsung,exynos4210-usb2-phy";
 		reg = <0x125B0000 0x100>;
 		samsung,pmureg-phandle = <&pmu_system_controller>;
-		clocks = <&clock CLK_USB_DEVICE>, <&clock CLK_XUSBXTI>;
+		clocks = <&clock CLK_USB_DEVICE>, <&xusbxti>;
 		clock-names = "phy", "ref";
 		#phy-cells = <1>;
 		status = "disabled";
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 72fb11f..a533207 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -292,18 +292,6 @@
 		};
 	};

-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
-
 	fimd at 11c00000 {
 		pinctrl-0 = <&lcd_en &lcd_clk &lcd_data24 &pwm0_out>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 636d166..ca74220 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -29,6 +29,10 @@
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
 	};

+	xxti: xxti {
+		clock-frequency = <12000000>;
+	};
+
 	sdhci at 12530000 {
 		bus-width = <4>;
 		pinctrl-names = "default";
@@ -194,16 +198,4 @@
 			};
 		};
 	};
-
-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <12000000>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index f516da9..226ddfa 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -351,18 +351,6 @@
 		};
 	};

-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
-
 	dsi_0: dsi at 11C80000 {
 		vddcore-supply = <&vusb_reg>;
 		vddio-supply = <&vmipi_reg>;
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 6de0d45..97f5008 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -32,18 +32,6 @@
 		compatible = "none";
 	};

-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
-
 	vemmc_reg: voltage-regulator {
 	        compatible = "regulator-fixed";
 		regulator-name = "VMEM_VDD_2_8V";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index cacf614..d6c0a19 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -73,6 +73,8 @@
 		compatible = "samsung,exynos4210-clock";
 		reg = <0x10030000 0x20000>;
 		#clock-cells = <1>;
+		clocks = <&xxti>, <&xusbxti>;
+		clock-names = "xxti", "xusbxti";
 	};

 	pmu {
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index e2c0dca..69acc32 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -513,16 +513,4 @@
 			};
 		};
 	};
-
-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index ded0b70..9efc5b2 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -146,16 +146,4 @@
 	serial at 13830000 {
 		status = "okay";
 	};
-
-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index ea6929d..a193da7 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -78,16 +78,4 @@
 	serial at 13830000 {
 		status = "okay";
 	};
-
-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index a16db6c..bc2d9fd 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -36,18 +36,6 @@
 		reg = <0x0204F000 0x1000>;
 	};

-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti", "fixed-clock";
-			clock-frequency = <0>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti", "fixed-clock";
-			clock-frequency = <24000000>;
-		};
-	};
-
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 6d9a21a..0d62456 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -46,6 +46,8 @@
 		compatible = "samsung,exynos4412-clock";
 		reg = <0x10030000 0x20000>;
 		#clock-cells = <1>;
+		clocks = <&xxti>, <&xusbxti>;
+		clock-names = "xxti", "xusbxti";
 	};

 	mct at 10050000 {
--
1.7.9.5
