From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 13 Jul 2017 11:20:43 +0900
Subject: [PATCH v4 3/3] ARM: dts: exynos: Remove the display-timing and
 delay from rinato dts
In-Reply-To: <1499912443-3671-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1499912443-3671-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170713022057epcas1p464b817a426638cc1566e665aa7903ed7@epcas1p4.samsung.com>
Message-ID: <1499912443-3671-4-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display-timing and delay are included in the panel driver. So it
should be removed in dts.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 443e0c9..6b70c8d 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -242,28 +242,6 @@
 		vci-supply = <&ldo20_reg>;
 		reset-gpios = <&gpe0 1 GPIO_ACTIVE_LOW>;
 		te-gpios = <&gpx0 6 GPIO_ACTIVE_HIGH>;
-		power-on-delay= <30>;
-		power-off-delay= <120>;
-		reset-delay = <5>;
-		init-delay = <100>;
-		flip-horizontal;
-		flip-vertical;
-		panel-width-mm = <29>;
-		panel-height-mm = <29>;
-
-		display-timings {
-			timing-0 {
-				clock-frequency = <4600000>;
-				hactive = <320>;
-				vactive = <320>;
-				hfront-porch = <1>;
-				hback-porch = <1>;
-				hsync-len = <1>;
-				vfront-porch = <150>;
-				vback-porch = <1>;
-				vsync-len = <2>;
-			};
-		};
 
 		port {
 			dsi_in: endpoint {
-- 
1.9.1
