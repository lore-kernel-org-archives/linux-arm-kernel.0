From: yvo@apm.com (Y Vo)
Date: Wed, 17 Dec 2014 12:10:50 +0700
Subject: [PATCH v2 RESEND 3/3] arm64:dts: Add APM X-Gene standby GPIO
 controller DTS entries
In-Reply-To: <1418793050-26927-1-git-send-email-yvo@apm.com>
References: <1418793050-26927-1-git-send-email-yvo@apm.com>
Message-ID: <1418793050-26927-4-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add standby domain gpio controller for APM X-Gene SoC platform.

Signed-off-by: Y Vo <yvo@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 295c72d..e2454a2 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -587,6 +587,19 @@
 			phy-names = "sata-phy";
 		};
 
+		sbgpio: sbgpio at 17001000{
+			compatible = "apm,xgene-gpio-sb";
+			reg = <0x0 0x17001000 0x0 0x400>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupts = 	<0x0 0x28 0x1>,
+					<0x0 0x29 0x1>,
+					<0x0 0x2a 0x1>,
+					<0x0 0x2b 0x1>,
+					<0x0 0x2c 0x1>,
+					<0x0 0x2d 0x1>;
+		};
+
 		rtc: rtc at 10510000 {
 			compatible = "apm,xgene-rtc";
 			reg = <0x0 0x10510000 0x0 0x400>;
-- 
2.2.0
