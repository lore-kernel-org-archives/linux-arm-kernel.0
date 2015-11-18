From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 18 Nov 2015 10:23:53 -0300
Subject: [RESEND PATCH v2 5/6] ARM: dts: Remove broken-cd from eMMC node in
 exynos5420-peach-pi
In-Reply-To: <1447853034-22508-1-git-send-email-javier@osg.samsung.com>
References: <1447853034-22508-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1447853034-22508-6-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC is non-removable so is marked with the non-removable DT
property to avoid having to redetect it after a suspend/resume.

But it also has the broken-cd property which is wrong since only
one of the DT properties for card detection should be used.

Also remove the card-detect-delay property that is not needed with
non-removable.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 02e99dbafcfb..35cfb07dc4bb 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -690,11 +690,9 @@
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
-	broken-cd;
 	mmc-hs200-1_8v;
 	cap-mmc-highspeed;
 	non-removable;
-	card-detect-delay = <200>;
 	clock-frequency = <400000000>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
-- 
2.4.3
