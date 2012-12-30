From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 29 Dec 2012 16:33:36 -0800
Subject: [PATCH v5 07/12] ARM: dts: add xxti and xusbxti fixed rate clock
 nodes for exynos4 based platforms
In-Reply-To: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1356827621-27617-8-git-send-email-thomas.abraham@linaro.org>
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
 arch/arm/boot/dts/exynos4412-origen.dts   |   12 ++++++++++++
 arch/arm/boot/dts/exynos4412-smdk4412.dts |   12 ++++++++++++
 4 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index f271001..d892ccc 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -121,4 +121,16 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 9b23a82..9a379eb 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -189,4 +189,16 @@
 			};
 		};
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index df880c4..7870bee 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -42,4 +42,16 @@
 	serial at 13830000 {
 		status = "okay";
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index f05bf57..8f422fc 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -42,4 +42,16 @@
 	serial at 13830000 {
 		status = "okay";
 	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
 };
-- 
1.7.5.4
