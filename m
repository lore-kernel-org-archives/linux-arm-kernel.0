From: joelf@ti.com (Joel Fernandes)
Date: Thu, 21 Nov 2013 19:56:53 -0600
Subject: [PATCH 7/8] ARM: DTS: am33xx: Provide the ti,timer-parent property
In-Reply-To: <1385085414-9034-1-git-send-email-joelf@ti.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
Message-ID: <1385085414-9034-8-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the clock alias of the parent clock for the system timer, using the
just added ti,timer-parent property.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f9c5da9..3934630 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -259,6 +259,7 @@
 			interrupts = <67>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
+			ti,timer-parent = "timer_sys_ck";
 		};
 
 		timer2: timer at 48040000 {
@@ -266,6 +267,7 @@
 			reg = <0x48040000 0x400>;
 			interrupts = <68>;
 			ti,hwmods = "timer2";
+			ti,timer-parent = "timer_sys_ck";
 		};
 
 		timer3: timer at 48042000 {
-- 
1.8.1.2
