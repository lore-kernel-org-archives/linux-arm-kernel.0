From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 24 Sep 2014 23:42:36 +0200
Subject: [PATCH 1/2] ARM: dts: Fix chip select GPIO on smdk5250
Message-ID: <1411594957-10681-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 65bbe3f ("ARM: dts: Clean up exynos5250-smdk5250") improved
the smdk5250 DTS but the patch was rebased due conflicting changes
and the merge resolution added a regression of the bug fixed in commit
e138d43 ("ARM: dts: fix the chip select gpios definition in the SPI nodes").

This patch fixes the issue by removing the old cs-gpio and using
the generic cs-gpios property.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index e17c02c..bc27cc2 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -385,6 +385,7 @@
 
 &spi_1 {
 	status = "okay";
+	cs-gpios = <&gpa2 5 GPIO_ACTIVE_HIGH>;
 
 	w25q80bw at 0 {
 		#address-cells = <1>;
@@ -394,7 +395,6 @@
 		spi-max-frequency = <1000000>;
 
 		controller-data {
-			cs-gpio = <&gpa2 5 GPIO_ACTIVE_HIGH>;
 			samsung,spi-feedback-delay = <0>;
 		};
 
-- 
2.1.0
