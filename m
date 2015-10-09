From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 10 Oct 2015 00:10:24 +0200
Subject: [PATCH 1/2] arm: mvebu: disable unused Armada RTC on ReadyNAS 102,
 104 and 2120
In-Reply-To: <cover.1444428035.git.arno@natisbad.org>
References: <cover.1444428035.git.arno@natisbad.org>
Message-ID: <2e62abb84de02c0495bde9d60a90282deae40967.1444428035.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


By default, armada-370-xp.dtsi file has internal RTC enabled.
NETGEAR ReadyNAS 102, 104 and 2120 all use an Intersil ISL12057
I2C RTC chip. The internal RTC not being disabled in the .dts
files of those devices result in the following useless first
line during boot:

[    4.500056] rtc-mv d0010300.rtc: internal RTC not ticking
[    4.505684] i2c /dev entries driver
[    4.513246] rtc-isl12057 0-0068: rtc core: registered rtc-isl12057 as rtc0

This patch marks Armada internal RTC as disabled in individual .dts
files of those devices.

Reported-by: TuxOholic <tuxoholic@hotmail.de>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 6 ++++++
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 6 ++++++
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index a31207860f34..5851964196bd 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -82,6 +82,12 @@
 		};
 
 		internal-regs {
+
+			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
+			rtc at 10300 {
+				status = "disabled";
+			};
+
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 00540f292979..b0b07ba677b9 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -82,6 +82,12 @@
 		};
 
 		internal-regs {
+
+			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
+			rtc at 10300 {
+				status = "disabled";
+			};
+
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 1516fc2627f9..85b2f87c0b8a 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -88,6 +88,12 @@
 		};
 
 		internal-regs {
+
+			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
+			rtc at 10300 {
+				status = "disabled";
+			};
+
 			/* Two rear eSATA ports */
 			sata at a0000 {
 				nr-ports = <2>;
-- 
2.5.3
