From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 14 Dec 2014 02:43:02 +0100
Subject: [PATCHv0 4/5] ARM: mvebu: ISL12057 rtc chip can be used to wake up
 RN2120
In-Reply-To: <cover.1418519430.git.arno@natisbad.org>
References: <cover.1418519430.git.arno@natisbad.org>
Message-ID: <14bf3eb38c0a14d4818bf4456aa2fe9d6ea84ebb.1418519430.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that alarm support for ISL12057 chip is available, let's use a
feature of the driver dedicated to NETGEAR ReadyNAS 2120 specific
routing of RTC IRQ#1 pin; on the device, this pin is not connected
to the SoC but to a PMIC, which allows the device to be powered
up when RTC alarm rings.

For that to work, the chip needs to be explicitly marked as a
device wakeup source using the "can-wakeup-machine" boolean
property. This makes 'wakealarm' sysfs entry available to
configure the alarm.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index d81430aa4ab3..f5c7cb52f1f9 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -100,6 +100,7 @@
 				isl12057: isl12057 at 68 {
 					compatible = "isil,isl12057";
 					reg = <0x68>;
+					can-wakeup-machine;
 				};
 
 				/* Controller for rear fan #1 of 3 (Protechnic
-- 
2.1.1
