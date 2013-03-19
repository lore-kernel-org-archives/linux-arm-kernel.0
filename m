From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Mar 2013 19:00:49 +0530
Subject: [PATCH v2 03/11] ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch
 timer
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1363699857-5505-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Specify both secure as well as nonsecure PPI IRQ for arch
timer. This fixes the following errors seen on DT OMAP5 boot..

[    0.000000] arch_timer: No interrupt available, giving up

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index aefecf7..71be239 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -41,8 +41,9 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		/* 14th PPI IRQ, active low level-sensitive */
-		interrupts = <1 14 0x308>;
+		/* PPI secure/nonsecure IRQ, active low level-sensitive */
+		interrupts = <1 13 0x308>,
+			     <1 14 0x308>;
 		clock-frequency = <6144000>;
 	};
 
-- 
1.7.9.5
