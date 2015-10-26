From: yvo@apm.com (Y Vo)
Date: Mon, 26 Oct 2015 13:49:35 +0700
Subject: [PATCH v2 3/3] arm64: dts: Update APM X-Gene standby GPIO controller
 DTS entries
In-Reply-To: <1445842175-11446-1-git-send-email-yvo@apm.com>
References: <1445842175-11446-1-git-send-email-yvo@apm.com>
Message-ID: <1445842175-11446-4-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update APM X-Gene standby GPIO controller DTS entries to support GPIO
line configuration as input, output or external IRQ pin.

Signed-off-by: Y Vo <yvo@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 6c5ed11..40a79fb 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -765,12 +765,15 @@
 			reg = <0x0 0x17001000 0x0 0x400>;
 			#gpio-cells = <2>;
 			gpio-controller;
-			interrupts = 	<0x0 0x28 0x1>,
-					<0x0 0x29 0x1>,
-					<0x0 0x2a 0x1>,
-					<0x0 0x2b 0x1>,
-					<0x0 0x2c 0x1>,
-					<0x0 0x2d 0x1>;
+			interrupt-parent = <&gic>;
+			interrupts = 	<0x0 0x28 0x4>,
+					<0x0 0x29 0x4>,
+					<0x0 0x2a 0x4>,
+					<0x0 0x2b 0x4>,
+					<0x0 0x2c 0x4>,
+					<0x0 0x2d 0x4>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 
 		rtc: rtc at 10510000 {
-- 
1.7.1
