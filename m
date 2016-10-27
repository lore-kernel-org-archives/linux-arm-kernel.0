From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 27 Oct 2016 14:11:41 -0300
Subject: [PATCH 1/3] ARM: dts: exynos: Document eMMC/SD/SDIO devices in
 Exynos5250 Snow board
Message-ID: <1477588303-13681-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a cognitive load to figure out which mmc device node corresponds
to the eMMC flash, uSD card and WiFI SDIO module on the Snow boards.

So it's better to have comments in the DTS to make this more clear.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index d5d51916bb74..8f3a80430748 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -523,6 +523,7 @@
 	status = "okay";
 };
 
+/* eMMC flash */
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
@@ -536,6 +537,7 @@
 	cap-mmc-highspeed;
 };
 
+/* uSD card */
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
@@ -553,6 +555,8 @@
 /*
  * On Snow we've got SIP WiFi and so can keep drive strengths low to
  * reduce EMI.
+ *
+ * WiFi SDIO module
  */
 &mmc_3 {
 	status = "okay";
-- 
2.7.4
