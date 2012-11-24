From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 25 Nov 2012 02:48:00 +0530
Subject: [PATCH v4 07/12] ARM: dts: add xxti and xusbxti fixed rate clock
 nodes for exynos4 based platforms
In-Reply-To: <1353791885-2566-1-git-send-email-thomas.abraham@linaro.org>
References: <1353791885-2566-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1353791885-2566-8-git-send-email-thomas.abraham@linaro.org>
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
 arch/arm/boot/dts/exynos4412-smdk4412.dts |   12 ++++++++++++
 3 files changed, 36 insertions(+), 0 deletions(-)

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
1.7.4.4
