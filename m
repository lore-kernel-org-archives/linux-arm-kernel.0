From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 03 Dec 2014 13:34:05 +0100
Subject: [PATCH v2 4/7] ARM: dts: exynos4: add dependency between TV and LCD0
 power domains
In-Reply-To: <1416814256-24288-5-git-send-email-a.hajda@samsung.com>
References: <1416814256-24288-5-git-send-email-a.hajda@samsung.com>
Message-ID: <1417610045-29790-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TV Mixer needs both TV and LCD0 domains enabled to be fully operational.
This dependency is modelled by making TV power domains a sub-domain of
LCD0 power domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 4ed5868d723e..55385a84a71c 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -97,6 +97,7 @@
 	pd_tv: tv-power-domain at 10023C20 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C20 0x20>;
+		samsung,power-domain = <&pd_lcd0>;
 	};
 
 	pd_cam: cam-power-domain at 10023C00 {
-- 
1.9.2
