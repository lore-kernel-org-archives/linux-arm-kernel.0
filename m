From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 19 Oct 2013 18:49:42 +0200
Subject: [PATCH v2 3/3] ARM: Dove: Add RTC interrupt via PMU interrupt
 controller.
In-Reply-To: <1382201382-15551-1-git-send-email-andrew@lunn.ch>
References: <1382201382-15551-1-git-send-email-andrew@lunn.ch>
Message-ID: <1382201382-15551-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC on Dove has an interrupt on the PMU interrupt controller.
Add this interrupt to the RTC node. Tested using the
"RTC Driver Test Example"

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---

Added Sebastians Tested-by.

 arch/arm/boot/dts/dove.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 52b992a..1fd615d 100644
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
