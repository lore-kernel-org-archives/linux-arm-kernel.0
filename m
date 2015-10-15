From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 15 Oct 2015 18:51:13 +0200
Subject: [RFT PATCH v2 6/6] ARM: dts: Mark eMMC as non-removable in
 exynos5250-snow-common
In-Reply-To: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
References: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1444927873-15140-7-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC is non-removable so mark it using the non-removable DT
property to avoid having to redetect it after a suspend/resume.

Also remove the card-detect-delay property that is not needed with
non-removable.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
- None, new patch.

 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 1822c502a25a..5cb33ba5e296 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -520,8 +520,7 @@
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
-	broken-cd;
-	card-detect-delay = <200>;
+	non-removable;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-- 
2.4.3
