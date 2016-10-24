From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 24 Oct 2016 14:12:09 +0200
Subject: [PATCH v3 4/5] ARM: dts: exynos: add support for ISP power domain to
 exynos4x12 clocks device
In-Reply-To: <1477311130-6534-1-git-send-email-m.szyprowski@samsung.com>
References: <1477311130-6534-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161024121228eucas1p12e92e725af3073597614d1065373d262@eucas1p1.samsung.com>
Message-ID: <1477311130-6534-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4412 clock controller contains some additional clocks for FIMC-ISP
(Camera ISP) subsystem. Registers for those clocks are partially located
in the SOC area, which belongs to ISP power domain.

This patch implements integration of ISP clocks with ISP power domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 0074f566cd3b..5667fd33dc98 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -74,6 +74,11 @@
 		compatible = "samsung,exynos4412-clock";
 		reg = <0x10030000 0x20000>;
 		#clock-cells = <1>;
+
+		isp-clock-controller {
+			compatible = "samsung,exynos4412-isp-clock";
+			power-domains = <&pd_isp>;
+		};
 	};
 
 	mct at 10050000 {
-- 
1.9.1
