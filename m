From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 21:08:52 +0530
Subject: [PATCH 5/8] ARM: dts: OMAP5: Update the timer and gic nodes for HYP
 kernel support
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1361374735-22018-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to run kernel in HYP mode, virtual timer and gic node information
needs to be popullated.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 5b6b72c..fa0c66b 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -46,7 +46,9 @@
 		compatible = "arm,armv7-timer";
 		/* PPI secure/nonsecure IRQ, active low level-sensitive */
 		interrupts = <1 13 0x308>,
-			     <1 14 0x308>;
+			     <1 14 0x308>,
+			     <1 11 0x308>,
+			     <1 10 0x308>;
 		clock-frequency = <6144000>;
 	};
 
@@ -55,7 +57,9 @@
 		interrupt-controller;
 		#interrupt-cells = <3>;
 		reg = <0x48211000 0x1000>,
-		      <0x48212000 0x1000>;
+		      <0x48212000 0x1000>,
+		      <0x48214000 0x2000>,
+		      <0x48216000 0x2000>;
 	};
 
 	/*
-- 
1.7.9.5
