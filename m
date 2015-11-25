From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 25 Nov 2015 13:55:26 +0100
Subject: [PATCH] ARM: dts: exynos4210: Add power domain to G2D device
In-Reply-To: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
References: <1448456127-31842-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1448456127-31842-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

G2D device and it's SYSMMU belongs to LCD0 power domain on Exynos 4210,
so add missing power-domains property to G2D device node (G2D's SYSMMU is
already bound to LCD0 power domain).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index aac0f17..d254200 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -185,6 +185,7 @@
 		interrupts = <0 89 0>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
+		power-domains = <&pd_lcd0>;
 		iommus = <&sysmmu_g2d>;
 		status = "disabled";
 	};
-- 
1.9.2
