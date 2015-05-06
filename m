From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed,  6 May 2015 18:32:59 +0200
Subject: [PATCH 1/1] ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for
 Snow
Message-ID: <1430929979-18119-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell mwifiex driver prevents the system to enter into a suspend
state if the card power is not preserved during a suspend/resume cycle.

So Suspend-to-RAM and Suspend-to-idle are failing on Exynos5250 Snow.

Add the keep-power-in-suspend Power Management property to the SDIO/MMC
node so the mwifiex suspend handler doesn't fail and the system is able
to enter into a suspend state.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Kukjin and Krzysztof,

I didn't notice that Snow was also missing this property when I did the
same change for Peach Pit and and Pi Chromebooks [0], sorry about that.

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/4/7/377
---
 arch/arm/boot/dts/exynos5250-snow.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 2657e842e5a5..1eca97ee4bd6 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -567,6 +567,7 @@
 	num-slots = <1>;
 	broken-cd;
 	cap-sdio-irq;
+	keep-power-in-suspend;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
-- 
2.1.4
