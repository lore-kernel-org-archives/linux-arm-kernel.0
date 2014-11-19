From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 19 Nov 2014 16:56:22 +0100
Subject: [PATCH 2/4] ARM: dts: Add temperature sensor to exynos5250-spring
In-Reply-To: <1416412585-10809-1-git-send-email-afaerber@suse.de>
References: <1416412585-10809-1-git-send-email-afaerber@suse.de>
Message-ID: <1416412585-10809-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spotted in the Chrome OS 3.8 based device tree.
Needs CONFIG_SENSORS_LM90.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5250-spring.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 310764b6e28d..cc3361afba49 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -383,6 +383,11 @@
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <66000>;
+
+	temperature-sensor at 4c {
+		compatible = "gmt,g781";
+		reg = <0x4c>;
+	};
 };
 
 &i2c_8 {
-- 
2.1.2
