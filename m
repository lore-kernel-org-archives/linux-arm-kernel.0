From: tobetter@gmail.com (Dongjin Kim)
Date: Sat, 22 Dec 2012 02:37:02 +0900
Subject: [PATCH v2 3/4] ODROID-X: dts: Add nodes for leds based on GPIO.
In-Reply-To: <1356111423-3454-1-git-send-email-tobetter@gmail.com>
References: <1356111423-3454-1-git-send-email-tobetter@gmail.com>
Message-ID: <1356111423-3454-4-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds GPIO connected LEDS on ODROID-X board, and describe its
properties.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 3d53663..e5c57c1 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -54,4 +54,18 @@
 		enable-active-high;
 		regulator-boot-on;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			label = "led1:heart";
+			gpios = <&gpc1 0 0>;
+			linux,default-trigger = "heartbeat";
+		};
+		led2 {
+			label = "led2:mmc0";
+			gpios = <&gpc1 2 0>;
+			linux,default-trigger = "mmc0";
+		};
+	};
 };
-- 
1.7.9.5
