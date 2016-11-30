From: sw0312.kim@samsung.com (Seung-Woo Kim)
Date: Wed, 30 Nov 2016 13:27:42 +0900
Subject: [PATCH] arm64: dts: exynos: Add flash led dt node for TM2 board
Message-ID: <1480480062-3472-1-git-send-email-sw0312.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ingi Kim <ingi2.kim@samsung.com>

This patch adds Kinetic ktd2692 flash led device node for TM2 board.

Signed-off-by: Ingi Kim <ingi2.kim@samsung.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index f21bdc2..3ba305f 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -58,6 +58,19 @@
 		reg = <0x0 0x20000000 0x0 0xc0000000>;
 	};
 
+	camera-flash {
+		compatible = "kinetic,ktd2692";
+		ctrl-gpios = <&gpc0 1 0>;
+		aux-gpios = <&gpc0 2 0>;
+
+		flash-led {
+			label = "ktd2692-flash";
+			led-max-microamp = <300000>;
+			flash-max-microamp = <1500000>;
+			flash-max-timeout-us = <1835000>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
1.7.4.1
