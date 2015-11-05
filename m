From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Thu, 05 Nov 2015 17:22:21 +0530
Subject: [PATCH v2 2/2] arm64: dts: exynos7: Enable HS200 mode operation
In-Reply-To: <1446724341-3568-1-git-send-email-alim.akhtar@samsung.com>
References: <1446724341-3568-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1446724341-3568-2-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables HS200 mode operation on exynos7 based
espresso board.
This also removes _broken-cd_ property as per mmc binding documentation
which says one of the properties between broken-cd and non-removable
should be used. And we already use _non-removable_ as emmc mounted
on board which is a non-removable device.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
Changes since v1:
* Addressed Krzysztof review comments

 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index f5a3da50ac57..d8767b00862e 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -333,8 +333,8 @@
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
-	broken-cd;
 	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
 	non-removable;
 	card-detect-delay = <200>;
 	clock-frequency = <800000000>;
-- 
1.7.10.4
