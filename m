From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 01 Sep 2016 15:45:50 +0200
Subject: [PATCH 4/5] ARM: dts: exynos: add support for ISP power domain to
 exynos4x12 clocks device
In-Reply-To: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1472737551-15272-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4412 clock controller contains some additional clocks for FIMC-ISP
(Camera ISP) subsystem. Registers for those clocks are partially located
in the SOC area, which belongs to ISP power domain.

This patch extends clock controller node with ISP clock sub-node and link
(phandle) to ISP power domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 3394bdcf10ae..4daea67546b9 100644
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
