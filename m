From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 15:04:04 -0800
Subject: [PATCH 3/4] ARM: dts: Add RTC entry for dm814x and dra62x
In-Reply-To: <1456182245-1843-1-git-send-email-tony@atomide.com>
References: <1456182245-1843-1-git-send-email-tony@atomide.com>
Message-ID: <1456182245-1843-4-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTC entry for dm814x and dra62x.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 3fe68b1..f752ac1 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -305,6 +305,13 @@
 				reg = <0x60000 0x1000>;
 			};
 
+			rtc: rtc at c0000 {
+				compatible = "ti,am3352-rtc", "ti,da830-rtc";
+				reg = <0xc0000 0x1000>;
+				interrupts = <75 76>;
+				ti,hwmods = "rtc";
+			};
+
 			mmc2: mmc at 1d8000 {
 				compatible = "ti,omap4-hsmmc";
 				ti,hwmods = "mmc2";
-- 
2.7.0
