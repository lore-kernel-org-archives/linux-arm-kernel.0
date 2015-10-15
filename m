From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 15 Oct 2015 12:55:29 +0200
Subject: [PATCH 2/3] ARM: dts: Mark SDIO as non-removable in
 exynos5420-peach-pit
In-Reply-To: <1444906530-25048-1-git-send-email-javier@osg.samsung.com>
References: <1444906530-25048-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1444906530-25048-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5420 Peach Pit Chromebook has a Marvell WiFi SDIO chip which
can't neither be removed nor be detected. But the node isn't marked
as non-removable and instead has the broken-cd DT property.

This causes the device to be removed when the system enters into a
suspend state and the following warnings is shown after a resume:

[  181.944636] mmc2: error -2 during resume (card was removed?)

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 72ba6f032ed7..293bf6a76a16 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -690,7 +690,7 @@
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
-	broken-cd;
+	non-removable;
 	mmc-hs200-1_8v;
 	cap-mmc-highspeed;
 	non-removable;
-- 
2.4.3
