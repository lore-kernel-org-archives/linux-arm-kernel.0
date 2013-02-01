From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 01 Feb 2013 20:09:29 +0100
Subject: [PATCH v4 08/10] ARM: dts: Add ISP power domain node for Exynos4x12
In-Reply-To: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
References: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1359745771-23684-9-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ISP power domain is a common power domain for fimc-lite
and fimc-is (ISP) devices.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 179a62e..9c809b72 100644
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
 	combiner:interrupt-controller at 10440000 {
 		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
 			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-- 
1.7.9.5
