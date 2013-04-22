From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 22 Apr 2013 17:05:08 +0530
Subject: [PATCH v2 2/2] ARM: dts: Add chip-id controller node on Exynos4/5 SoC
In-Reply-To: <1366630508-26101-1-git-send-email-thomas.abraham@linaro.org>
References: <1366630508-26101-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1366630508-26101-3-git-send-email-thomas.abraham@linaro.org>
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
index d73eaa1..efd441a 100644
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
index 6727eed..4bd9e9c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -51,6 +51,11 @@
 		pinctrl3 = &pinctrl_3;
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
1.6.6.rc2
