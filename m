From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 21 Apr 2015 15:17:52 +0200
Subject: [PATCH 2/8] ARM: dts: add cluster regulator supply properties for
 exynos5422-odroidxu3
In-Reply-To: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com>
References: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1429622278-12216-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cluster regulator supply properties as a preparation to
adding generic arm_big_little_dt cpufreq driver support for
ODROID-XU3 board.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index edc25cf..e876016 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -355,6 +355,14 @@
 	dr_mode = "otg";
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_0 {
 	status = "okay";
 
-- 
1.7.9.5
