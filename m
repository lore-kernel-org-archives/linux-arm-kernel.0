From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat,  2 Aug 2014 02:52:28 +0200
Subject: [PATCH v6 08/10] ARM: dts: Fix apparent GPIO typo in
 exynos5250-arndale
In-Reply-To: <1406940750-15880-1-git-send-email-afaerber@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
Message-ID: <1406940750-15880-9-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO flag 2 has no constant assigned, so this was probably active-low.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v5 -> v6: Unchanged
 
 v5: New
 Spotted during cleanup.

 arch/arm/boot/dts/exynos5250-arndale.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index aac41c394d43..cc8b9ffeecc1 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -159,7 +159,7 @@
 };
 
 &hdmi {
-	hpd-gpio = <&gpx3 7 2>;
+	hpd-gpio = <&gpx3 7 GPIO_ACTIVE_LOW>;
 	vdd_osc-supply = <&ldo10_reg>;
 	vdd_pll-supply = <&ldo8_reg>;
 	vdd-supply = <&ldo8_reg>;
-- 
1.9.3
