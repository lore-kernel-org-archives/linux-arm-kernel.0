From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 12 Mar 2015 18:31:26 +0000
Subject: [PATCH 7/9] ARM: dt: dove: wire up RTC interrupt
In-Reply-To: <20150312183020.GU8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Message-ID: <E1YW7tG-0003mQ-DQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a PMU driver, we can wire up the RTC interrupt in the
DT description for Dove.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 43d4ebf414be..7e80407bdcf8 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -624,6 +624,8 @@
 			rtc: real-time-clock at d8500 {
 				compatible = "marvell,orion-rtc";
 				reg = <0xd8500 0x20>;
+				interrupt-parent = <&pmu>;
+				interrupts = <5>;
 			};
 
 			gconf: global-config at e802c {
-- 
1.8.3.1
