From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:24:59 +0530
Subject: [PATCH 2/2] ARM: dts: Add chip-id controller node on Exynos4/5 SoC
In-Reply-To: <1361174099-18749-1-git-send-email-thomas.abraham@linaro.org>
References: <1361174099-18749-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361174099-18749-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add chip-id controller nodes for Exynos4 and Exynos5 SoCs.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4.dtsi    |    5 +++++
 arch/arm/boot/dts/exynos5250.dtsi |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 6581bb2..1a02189 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -38,6 +38,11 @@
 		i2c7 = &i2c_7;
 	};
 
+	chipid at 10000000 {
+		compatible = "samsung,exynos4210-chipid";
+		reg = <0x10000000 0x100>;
+	};
+
 	pd_mfc: mfc-power-domain at 10023C40 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C40 0x20>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 7c3d07a..fce773e 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -46,6 +46,11 @@
 		i2c8 = &i2c_8;
 	};
 
+	chipid at 10000000 {
+		compatible = "samsung,exynos4210-chipid";
+		reg = <0x10000000 0x100>;
+	};
+
 	pd_gsc: gsc-power-domain at 0x10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
-- 
1.7.5.4
