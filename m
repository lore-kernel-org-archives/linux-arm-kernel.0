From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 13 Nov 2012 13:51:55 +0100
Subject: [PATCH v3 4/4] ARM: dts: exynos4: Set up power domains
In-Reply-To: <1352811115-1198-1-git-send-email-t.figa@samsung.com>
References: <1352811115-1198-1-git-send-email-t.figa@samsung.com>
Message-ID: <1352811115-1198-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes for power domains available
on Exynos 4 SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index a26c3dd..0c14f50 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -30,6 +30,36 @@
 		spi2 = &spi_2;
 	};
 
+	pd_mfc: mfc-power-domain at 10023C40 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C40 0x20>;
+	};
+
+	pd_g3d: g3d-power-domain at 10023C60 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C60 0x20>;
+	};
+
+	pd_lcd0: lcd0-power-domain at 10023C80 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C80 0x20>;
+	};
+
+	pd_tv: tv-power-domain at 10023C20 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C20 0x20>;
+	};
+
+	pd_cam: cam-power-domain at 10023C00 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C00 0x20>;
+	};
+
+	pd_gps: gps-power-domain at 10023CE0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023CE0 0x20>;
+	};
+
 	gic:interrupt-controller at 10490000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 939f639..e31bfc4 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -31,6 +31,11 @@
 		pinctrl2 = &pinctrl_2;
 	};
 
+	pd_lcd1: lcd1-power-domain at 10023CA0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023CA0 0x20>;
+	};
+
 	gic:interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
-- 
1.8.0
