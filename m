From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 14 Jan 2015 14:44:48 +0100
Subject: [PATCH v3 4/7] ARM: dts: exynos4: add dependency between TV and LCD0
 power domains
In-Reply-To: <1421243091-10778-1-git-send-email-m.szyprowski@samsung.com>
References: <1421243091-10778-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1421243091-10778-5-git-send-email-m.szyprowski@samsung.com>
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
index d951647..a59b3fae 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -101,6 +101,7 @@
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C20 0x20>;
 		#power-domain-cells = <0>;
+		power-domains = <&pd_lcd0>;
 	};
 
 	pd_cam: cam-power-domain at 10023C00 {
-- 
1.9.2
