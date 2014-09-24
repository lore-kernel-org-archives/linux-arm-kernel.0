From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 24 Sep 2014 23:42:37 +0200
Subject: [PATCH 2/2] ARM: dts: Remove display timings node from exynos5250-snow
In-Reply-To: <1411594957-10681-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1411594957-10681-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1411594957-10681-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a3d72ca ("ARM: dts: Clean up exynos5250-snow") improved
the Snow DTS but the patch was rebased due conflicting changes
and the merge resolution added a device node removed by commit
a98c3c2 ("ARM: dts: update display related nodes for exynos5250-snow").

This patch removes the node again to keep the DTS as before.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index e562459..f9bc04b 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -241,22 +241,6 @@
 	samsung,lane-count = <2>;
 	samsung,hpd-gpio = <&gpx0 7 GPIO_ACTIVE_HIGH>;
 	bridge = <&ptn3460>;
-
-	display-timings {
-		native-mode = <&timing1>;
-
-		timing1: timing at 1 {
-			clock-frequency = <70589280>;
-			hactive = <1366>;
-			vactive = <768>;
-			hfront-porch = <40>;
-			hback-porch = <40>;
-			hsync-len = <32>;
-			vback-porch = <10>;
-			vfront-porch = <12>;
-			vsync-len = <6>;
-		};
-	};
 };
 
 &ehci {
-- 
2.1.0
