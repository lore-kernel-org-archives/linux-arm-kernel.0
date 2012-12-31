From: tobetter@gmail.com (Dongjin Kim)
Date: Mon, 31 Dec 2012 11:35:12 +0900
Subject: [PATCH v3 3/4] ODROID-X: dts: Add nodes for leds based on GPIO.
In-Reply-To: <1356921314-12595-1-git-send-email-tobetter@gmail.com>
References: <1356921314-12595-1-git-send-email-tobetter@gmail.com>
Message-ID: <1356921314-12595-4-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds GPIO connected LEDS on ODROID-X board and configure its
properties.

LED1: use 'heartbeat' trigger, blinking while the board is running.
LED2: use 'mmc0' trigger, on when mmc0 is accessing.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 213b152..f31529f 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -54,4 +54,20 @@
 		enable-active-high;
 		regulator-boot-on;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			label = "led1:heart";
+			gpios = <&gpc1 0 1>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+		led2 {
+			label = "led2:mmc0";
+			gpios = <&gpc1 2 1>;
+			default-state = "on";
+			linux,default-trigger = "mmc0";
+		};
+	};
 };
-- 
1.7.10.4
