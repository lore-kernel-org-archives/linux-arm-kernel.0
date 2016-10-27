From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 27 Oct 2016 14:11:42 -0300
Subject: [PATCH 2/3] ARM: dts: exynos: Document eMMC/SD/SDIO devices in
 Exynos5420 Pit board
In-Reply-To: <1477588303-13681-1-git-send-email-javier@osg.samsung.com>
References: <1477588303-13681-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1477588303-13681-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a cognitive load to figure out which mmc device nodes corresponds
to the eMMC flash, uSD card and WiFI SDIO module on the Peach Pit board.

So it's better to have comments in the DTS to make this more clear.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index ec4a00f1ce01..1f964ec35c5e 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -697,6 +697,7 @@
 	status = "okay";
 };
 
+/* eMMC flash */
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
@@ -714,6 +715,7 @@
 	bus-width = <8>;
 };
 
+/* WiFi SDIO module */
 &mmc_1 {
 	status = "okay";
 	num-slots = <1>;
@@ -733,6 +735,7 @@
 	vqmmc-supply = <&buck10_reg>;
 };
 
+/* uSD card */
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-- 
2.7.4
