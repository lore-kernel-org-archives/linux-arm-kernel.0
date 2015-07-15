From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:59:41 +0100
Subject: [PATCH 4/7] ARM: dt: dove: wire up RTC interrupt
In-Reply-To: <20150715185859.GC7557@n2100.arm.linux.org.uk>
References: <20150715185859.GC7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFRu9-0003mF-RQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a PMU driver, we can wire up the RTC interrupt in the
DT description for Dove.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 4f20278f2a20..d4d33266c65c 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -687,6 +687,7 @@
 				rtc: real-time-clock at 8500 {
 					compatible = "marvell,orion-rtc";
 					reg = <0x8500 0x20>;
+					interrupts = <5>;
 				};
 			};
 
-- 
2.1.0
