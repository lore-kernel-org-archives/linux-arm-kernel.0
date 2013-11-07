From: andrew@lunn.ch (Andrew Lunn)
Date: Thu,  7 Nov 2013 11:35:31 +0100
Subject: [RESEND PATCH v2 3/3] ARM: Dove: Add RTC interrupt via PMU interrupt
 controller.
In-Reply-To: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
References: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
Message-ID: <1383820531-4387-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC on Dove has an interrupt on the PMU interrupt controller.
Add this interrupt to the RTC node. Tested using the
"RTC Driver Test Example"

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/dove.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 52b992a5c120..1fd615d27532 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -426,6 +426,8 @@
 		rtc: real-time-clock at d8500 {
 			compatible = "marvell,orion-rtc";
 			reg = <0xd8500 0x20>;
+			interrupt-parent = <&pmu_intc>;
+			interrupts = <5>;
 		};
 
 		crypto: crypto-engine at 30000 {
-- 
1.8.4.rc3
