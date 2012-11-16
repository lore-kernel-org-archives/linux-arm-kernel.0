From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 16 Nov 2012 17:38:26 +0530
Subject: [PATCH v2 4/4] ARM: dts: AM33XX: Enable system power off control in
 am335x-bone
In-Reply-To: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
References: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
Message-ID: <1353067706-29491-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable system power off control for BeagleBone in am335x-bone.dts file
under rtc node. RTC is the incharge of controlling the system power.
This flag is used by the driver to hook up the pm_power_off system call.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 1d55190..206c3eb 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -52,6 +52,10 @@
 			};
 
 		};
+
+		rtc at 44e3e000 {
+			ti,system-power-controller;
+		};
 	};
 
 	leds {
-- 
1.7.9.5
