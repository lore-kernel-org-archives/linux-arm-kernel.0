From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 27 Oct 2016 14:11:43 -0300
Subject: [PATCH 3/3] ARM: dts: exynos: Document eMMC/SD/SDIO devices in
 Exynos5800 Peach Pi board
In-Reply-To: <1477588303-13681-1-git-send-email-javier@osg.samsung.com>
References: <1477588303-13681-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1477588303-13681-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a cognitive load to figure out which mmc device nodes corresponds
to the eMMC flash, uSD card and WiFI SDIO module on the Peach Pi board.

So it's better to have comments in the DTS to make this more clear.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5800-peach-pi.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 01f466816fea..f9ff7f07ae0c 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -665,6 +665,7 @@
 	status = "okay";
 };
 
+/* eMMC flash */
 &mmc_0 {
 	status = "okay";
 	num-slots = <1>;
@@ -683,6 +684,7 @@
 	bus-width = <8>;
 };
 
+/* WiFi SDIO module */
 &mmc_1 {
 	status = "okay";
 	num-slots = <1>;
@@ -702,6 +704,7 @@
 	vqmmc-supply = <&buck10_reg>;
 };
 
+/* uSD card */
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
-- 
2.7.4
