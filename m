From: qnguyen@apm.com (Quan Nguyen)
Date: Fri, 29 Jan 2016 11:28:55 +0700
Subject: [PATCH v5 3/3] arm64: dts: Update X-Gene standby GPIO controller DTS
 entries
In-Reply-To: <1454041735-8434-1-git-send-email-qnguyen@apm.com>
References: <1454041735-8434-1-git-send-email-qnguyen@apm.com>
Message-ID: <1454041735-8434-4-git-send-email-qnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update APM X-Gene standby GPIO controller DTS entries to enable it
as interrupt controller.

Signed-off-by: Y Vo <yvo@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index fe30f76..0f733da 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -883,6 +883,9 @@
 					<0x0 0x2b 0x1>,
 					<0x0 0x2c 0x1>,
 					<0x0 0x2d 0x1>;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 
 		rtc: rtc at 10510000 {
-- 
1.7.12.4
