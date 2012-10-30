From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 30 Oct 2012 15:04:01 +0530
Subject: [PATCH v2] ARM: dts: am33xx: rtc node
Message-ID: <1351589646-27082-1-git-send-email-afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add am33xx rtc node.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
Hi Benoit,

This is based on your for_3.8/dts branch.

This has been tested on Beagle Bone.

Bindings along with driver changes for DT has been picked by Andrew
Morton and is now present in linux-next.

Regards
Afzal

v2
 1. Remove interrupt parent in rtc node.
 2. Modify subject as per new convention.


 arch/arm/boot/dts/am33xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 70d24b8..97a7bd3 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -291,5 +291,13 @@
 			ti,hwmods = "timer7";
 			ti,timer-pwm;
 		};
+
+		rtc at 44e3e000 {
+			compatible = "ti,da830-rtc";
+			reg = <0x44e3e000 0x1000>;
+			interrupts = <75
+				      76>;
+			ti,hwmods = "rtc";
+		};
 	};
 };
-- 
1.7.12
