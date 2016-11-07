From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 07 Nov 2016 15:39:36 +0530
Subject: [PATCH 6/6] ARM: dts: Extend the S3C RTC node with rtc_src clock
In-Reply-To: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1478513376-14307-7-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the S3C RTC node with rtc_src clock so it could be operational.
The rtc_src clock is provided by MAX8997.

CC: Rob Herring <robh+dt@kernel.org>
CC: devicetree at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 6c7ef4e..4cac9b6 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -18,6 +18,7 @@
 #include "exynos4210.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/clock/maxim,max8997.h>
 #include "exynos-mfc-reserved-memory.dtsi"
 
 / {
@@ -324,6 +325,8 @@
 
 &rtc {
 	status = "okay";
+	clocks = <&clock CLK_RTC>, <&max8997 MAX8997_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &tmu {
-- 
2.7.4
