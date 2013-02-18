From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:51:26 +0530
Subject: [PATCH v6 16/16] ARM: dts: add board specific fixed rate clock nodes
 for Exynos based platforms
In-Reply-To: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175686-19400-17-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock frequency of xxti and xusbxti clocks is dependent on the frequency of the
on-board oscillator that is used to generate these clocks. So allow the frequency
of these clocks to be specfied from device tree.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts   |   12 ++++++++++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts |   12 ++++++++++++
 arch/arm/boot/dts/exynos4210-trats.dts    |   12 ++++++++++++
 arch/arm/boot/dts/exynos4412-odroidx.dts  |   12 ++++++++++++
 arch/arm/boot/dts/exynos4412-origen.dts   |   12 ++++++++++++
 arch/arm/boot/dts/exynos4412-smdk4412.dts |   12 ++++++++++++
 arch/arm/boot/dts/exynos5250-arndale.dts  |    7 +++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    7 +++++++
 arch/arm/boot/dts/exynos5250-snow.dts     |    7 +++++++
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    7 +++++++
 10 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 052606b..1b30bc8 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -127,4 +127,16 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 2b1e03a..f52c86e 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -195,4 +195,16 @@
 			};
 		};
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <12000000>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index c346b64..9a14484 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -289,4 +289,16 @@
 			};
 		};
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 0084d95..15dc0a3 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -94,4 +94,16 @@
 	serial at 13830000 {
 		status = "okay";
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 31e14c4..a944611 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -415,4 +415,16 @@
 			};
 		};
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index 6ae4276..874beea 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -55,4 +55,16 @@
 	serial at 13830000 {
 		status = "okay";
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 63572f9..5de019c 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -119,4 +119,11 @@
 	spi_2: spi at 12d40000 {
 		status = "disabled";
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 1391c31..f77bf3a 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -217,4 +217,11 @@
 		samsung,link-rate = <0x0a>;
 		samsung,lane-count = <4>;
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 47b6b84..babd9f9 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -44,4 +44,11 @@
 	usb at 12110000 {
 		samsung,vbus-gpio = <&gpx1 1 1 3 3>;
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index ee60c57..a21eb4c 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -27,4 +27,11 @@
 	spi {
 		status = "disabled";
 	};
+
+	fixed-rate-clocks {
+		xtal {
+			compatible = "samsung,clock-xtal";
+			clock-frequency = <50000000>;
+		};
+	};
 };
-- 
1.7.5.4
