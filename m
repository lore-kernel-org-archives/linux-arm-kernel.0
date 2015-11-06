From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 06 Nov 2015 08:36:40 +0530
Subject: [PATCH v3 2/2] arm64: dts: exynos7: Enable HS200 mode operation
In-Reply-To: <1446779200-10457-1-git-send-email-alim.akhtar@samsung.com>
References: <1446779200-10457-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1446779200-10457-2-git-send-email-alim.akhtar@samsung.com>
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
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
Chnages since v2:
* none

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
