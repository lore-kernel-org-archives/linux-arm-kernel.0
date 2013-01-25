From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Jan 2013 18:32:44 +0100
Subject: [PATCH v2 4/5] arm: mvebu: update DT to support local timers
In-Reply-To: <1359135165-32108-1-git-send-email-gregory.clement@free-electrons.com>
References: <1359135165-32108-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1359135165-32108-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the time-armada-370-xp support local timers, updated the
device tree to take it into account.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 4c0abe8..aa6a187 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -68,8 +68,9 @@
 
 		timer at d0020300 {
 			       compatible = "marvell,armada-370-xp-timer";
-			       reg = <0xd0020300 0x30>;
-			       interrupts = <37>, <38>, <39>, <40>;
+			       reg = <0xd0020300 0x30>,
+			       <0xd0021040 0x30>;
+			       interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
 			       clocks = <&coreclk 2>;
 		};
 
-- 
1.7.9.5
