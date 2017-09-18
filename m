From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Mon, 18 Sep 2017 11:54:24 +0900
Subject: [RESEND PATCH v4 3/3] ARM: dts: exynos: Remove the display-timing
 and delay from rinato dts
References: <CGME20170918025448epcas2p22a44b6c8efeac613e7e90c3c49b3eb8a@epcas2p2.samsung.com>
Message-ID: <1505703264-6704-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 The display-timing and delay are included in the panel driver. So it
 should be removed in dts.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---

Hi Krzysztof,

This patch was rebased to the mainline (v4.14-rc1).

Best regards,
Hoegeun

 arch/arm/boot/dts/exynos3250-rinato.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 0b45467..ff792ff 100644
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
