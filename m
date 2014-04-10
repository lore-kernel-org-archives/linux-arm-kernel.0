From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:15 +0900
Subject: [PATCH 25/27] ARM: dts: exynos3250: Add RTC dt node
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-17-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <t.figa@samsung.com>

This patch add rtc dt node for Real Time Clock (RTC) which operates with
a backup battery when the system is off and performs the function of an alarm.

Exynos3250's RTC has following rtc interrupt
- ALARM_INT (alarm interrupt)
- ALAREM_WK (alarm wake-up)

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index c8bd33cf..a61940f 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -88,6 +88,13 @@
 		#clock-cells = <1>;
 	};
 
+	rtc at 10070000 {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x10070000 0x100>;
+		interrupts = <0 73 0>, <0 74 0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at 10481000 {
 		compatible = "arm,cortex-a7-gic";
 		#interrupt-cells = <3>;
-- 
1.8.0
