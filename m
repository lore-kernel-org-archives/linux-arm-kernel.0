From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 15 Jun 2017 19:03:30 +0900
Subject: [PATCH v2 4/4] ARM: dts: exynos: Remove the display-timing and
 delay from rinato dts
In-Reply-To: <1497521010-8429-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1497521010-8429-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170615100342epcas1p43156787a99d5889734b54e8dbf83b42a@epcas1p4.samsung.com>
Message-ID: <1497521010-8429-5-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display-timing and delay are included in the panel driver. So it
should be removed in dts.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index de2702e..3df88383 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -227,28 +227,6 @@
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
 	};
 };
 
-- 
1.9.1
