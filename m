From: qnguyen@apm.com (Quan Nguyen)
Date: Thu,  7 Jan 2016 17:27:08 +0700
Subject: [PATCH v3 3/3] arm64: dts: Update X-Gene standby GPIO controller DTS
 entries
In-Reply-To: <1452162428-26839-1-git-send-email-qnguyen@apm.com>
References: <1452162428-26839-1-git-send-email-qnguyen@apm.com>
Message-ID: <1452162428-26839-4-git-send-email-qnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update APM X-Gene standby GPIO controller DTS entries to support
GPIO line configuration as input, output or external IRQ pin.

Signed-off-by: Y Vo <yvo@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index a21e08a..c534a19 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -891,12 +891,15 @@
 			reg = <0x0 0x17001000 0x0 0x400>;
 			#gpio-cells = <2>;
 			gpio-controller;
-			interrupts = 	<0x0 0x28 0x1>,
+			interrupt-parent = <&gic>;
+			interrupts =	<0x0 0x28 0x1>,
 					<0x0 0x29 0x1>,
 					<0x0 0x2a 0x1>,
 					<0x0 0x2b 0x1>,
 					<0x0 0x2c 0x1>,
 					<0x0 0x2d 0x1>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 
 		rtc: rtc at 10510000 {
-- 
2.2.0
