From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:16 +0900
Subject: [PATCH 26/27] ARM: dts: exynos3250: Add power domain dt nodes
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-18-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Inki Dae <inki.dae@samsung.com>

This patch add CAM/MFC/G3D/LCD0/ISP power domain nodes for Exynos3250.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
[add CAM/MFC power domain node by Bartlomiej Zolnierkiewicz]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[add ISP power domain node by Bartlomiej Zolnierkiewicz]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index a61940f..192770a 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -82,6 +82,31 @@
 		reg = <0x10010000 0x400>;
 	};
 
+	pd_cam: cam-power-domain at 10023C00 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C00 0x20>;
+	};
+
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
+	pd_isp: isp-power-domain at 10023CA0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023CA0 0x20>;
+	};
+
 	cmu: clock-controller at 10030000 {
 		compatible = "samsung,exynos3250-cmu";
 		reg = <0x10030000 0x20000>;
-- 
1.8.0
