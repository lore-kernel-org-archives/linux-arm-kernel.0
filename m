From: yvo@apm.com (Y Vo)
Date: Wed, 21 Jan 2015 09:59:25 +0700
Subject: [PATCH v3 3/3] arm64: dts: Add APM X-Gene standby GPIO controller DTS
 entries
Message-ID: <1421809165-8520-1-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add standby domain gpio controller for APM X-Gene SoC platform.

Signed-off-by: Y Vo <yvo@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index f1ad9c2..2e1c438 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
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
1.7.1
