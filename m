From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 15 Oct 2015 18:51:11 +0200
Subject: [PATCH v2 4/6] ARM: dts: Remove broken-cd from eMMC node in
 exynos5800-peach-pi
In-Reply-To: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
References: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1444927873-15140-5-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC is non-removable so is marked with the non-removable DT
property to avoid having to redetect it after a suspend/resume.

But it also has the broken-cd property which is wrong since only
one of the DT properties for card detection should be used.

Also remove the card-detect-delay property that is not needed with
non-removable.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes since v1:
- None, new patch.

 arch/arm/boot/dts/exynos5800-peach-pi.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index ca3a467a585d..7b018e451880 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -652,12 +652,10 @@
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
-	broken-cd;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	cap-mmc-highspeed;
 	non-removable;
-	card-detect-delay = <200>;
 	clock-frequency = <800000000>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
-- 
2.4.3
