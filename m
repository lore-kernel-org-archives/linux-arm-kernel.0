From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 15:04:05 -0800
Subject: [PATCH 4/4] ARM: dts: Add RTC entry for dm816x
In-Reply-To: <1456182245-1843-1-git-send-email-tony@atomide.com>
References: <1456182245-1843-1-git-send-email-tony@atomide.com>
Message-ID: <1456182245-1843-5-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTC entry for dm816x.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index c3b8811..e850686 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -214,6 +214,13 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		rtc: rtc at 480c0000 {
+			compatible = "ti,am3352-rtc", "ti,da830-rtc";
+			reg = <0x480c0000 0x1000>;
+			interrupts = <75 76>;
+			ti,hwmods = "rtc";
+		};
+
 		mailbox: mailbox at 480c8000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x480c8000 0x2000>;
-- 
2.7.0
