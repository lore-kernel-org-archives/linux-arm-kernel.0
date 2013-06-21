From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Jun 2013 14:50:19 +0200
Subject: [PATCH 3/8] ARM: dts: Add ISP power domain node for Exynos4x12
In-Reply-To: <1371819024-12596-1-git-send-email-s.nawrocki@samsung.com>
References: <1371819024-12596-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1371819024-12596-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ISP power domain is a common power domain for FIMC-LITE
and FIMC-IS (camera ISP) devices.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 01da194..0e24d85 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -28,6 +28,11 @@
 		pinctrl3 = &pinctrl_3;
 	};
 
+	pd_isp: isp-power-domain at 10023CA0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023CA0 0x20>;
+	};
+
 	clock: clock-controller at 0x10030000 {
 		compatible = "samsung,exynos4412-clock";
 		reg = <0x10030000 0x20000>;
-- 
1.7.9.5
