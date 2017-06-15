From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 15 Jun 2017 19:03:29 +0900
Subject: [PATCH v2 3/4] ARM: dts: exynos: Fix the active of reset gpios from
 rinato dts
In-Reply-To: <1497521010-8429-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1497521010-8429-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170615100342epcas1p4feeb3d12bb9e120bf40dc5945c4b2460@epcas1p4.samsung.com>
Message-ID: <1497521010-8429-4-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reset gpios is active low, therefore fix from active high to low.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 82e676a..de2702e 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -225,7 +225,7 @@
 		reg = <0>;
 		vdd3-supply = <&ldo16_reg>;
 		vci-supply = <&ldo20_reg>;
-		reset-gpios = <&gpe0 1 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpe0 1 GPIO_ACTIVE_LOW>;
 		te-gpios = <&gpx0 6 GPIO_ACTIVE_HIGH>;
 		power-on-delay= <30>;
 		power-off-delay= <120>;
-- 
1.9.1
