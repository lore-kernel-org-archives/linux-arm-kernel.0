From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 15 Oct 2015 18:51:09 +0200
Subject: [PATCH v2 2/6] ARM: dts: Mark SDIO as non-removable in
 exynos5420-peach-pit
In-Reply-To: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
References: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1444927873-15140-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5420 Peach Pit Chromebook has a Marvell WiFi SDIO chip which
can't neither be removed nor be detected. But the node isn't marked
as non-removable and instead has the broken-cd DT property.

This causes the device to be removed when the system enters into a
suspend state and the following warnings is shown after a resume:

[  181.944636] mmc2: error -2 during resume (card was removed?)

Also remove the card-detect-delay property that is not needed with
non-removable.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes since v1:
- Remove card-detect-delay property as well.

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 72ba6f032ed7..02e99dbafcfb 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -709,10 +709,9 @@
 &mmc_1 {
 	status = "okay";
 	num-slots = <1>;
-	broken-cd;
+	non-removable;
 	cap-sdio-irq;
 	keep-power-in-suspend;
-	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
-- 
2.4.3
