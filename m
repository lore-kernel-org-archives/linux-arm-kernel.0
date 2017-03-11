From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 19:25:26 +0200
Subject: [PATCH v2 7/8] ARM: dts: s3c64xx: Fix infinite interrupt in soft mode
In-Reply-To: <20170311172527.16368-1-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
Message-ID: <20170311172527.16368-8-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
of an interrupt.  The interrupt has to be cleared, because otherwise
system enters infinite interrupt handling loop.

Use a samsung,s3c6410-wdt compatible to select appropriate quirk for
clearing the watchdog interrupt.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c64xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index 6caec5f27d38..c55cbb3af2c0 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -94,7 +94,7 @@
 		};
 
 		watchdog: watchdog at 7e004000 {
-			compatible = "samsung,s3c2410-wdt";
+			compatible = "samsung,s3c6410-wdt";
 			reg = <0x7e004000 0x1000>;
 			interrupt-parent = <&vic0>;
 			interrupts = <26>;
-- 
2.9.3
