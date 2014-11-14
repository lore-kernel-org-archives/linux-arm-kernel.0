From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 14 Nov 2014 11:08:51 +0100
Subject: [PATCH 3/4] ARM: at91/dt: enable the RTT block on the sam9g20ek board
In-Reply-To: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415959732-13591-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415959732-13591-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the RTT and GPBR devices and specify the general purpose register
used to store the current time.

Enable wakeup on RTT event on the shutdown controller device.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index d291910..dfaacb1 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -112,9 +112,23 @@
 				};
 			};
 
+			shdwc at fffffd10 {
+				atmel,wakeup-counter = <10>;
+				atmel,wakeup-rtt-timer;
+			};
+
+			rtc at fffffd20 {
+				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+				status = "okay";
+			};
+
 			watchdog at fffffd40 {
 				status = "okay";
 			};
+
+			gpbr: syscon at fffffd50 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.9.1
