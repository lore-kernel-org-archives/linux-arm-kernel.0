From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 19:25:23 +0200
Subject: [PATCH v2 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx
 boards
In-Reply-To: <20170311172527.16368-1-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
Message-ID: <20170311172527.16368-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Watchdog module does not have external dependencies so it can be safely
enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c64xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index 0ccb414cd268..6caec5f27d38 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -100,7 +100,6 @@
 			interrupts = <26>;
 			clock-names = "watchdog";
 			clocks = <&clocks PCLK_WDT>;
-			status = "disabled";
 		};
 
 		i2c0: i2c at 7f004000 {
-- 
2.9.3
