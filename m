From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri,  1 Aug 2014 06:54:55 +0200
Subject: [PATCH v5 08/10] ARM: dts: Fix apparent GPIO typo in
 exynos5250-arndale
In-Reply-To: <1406868897-26874-1-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
Message-ID: <1406868897-26874-9-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO flag 2 has no constant assigned, so this was probably active-low.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v5: New
 Spotted during cleanup.

 arch/arm/boot/dts/exynos5250-arndale.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 3a608f57f833..a04a875346aa 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -164,7 +164,7 @@
 };
 
 &hdmi {
-	hpd-gpio = <&gpx3 7 2>;
+	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_LOW>;
 	vdd_osc-supply = <&ldo10_reg>;
 	vdd_pll-supply = <&ldo8_reg>;
 	vdd-supply = <&ldo8_reg>;
-- 
1.9.3
