From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:28:45 +0200
Subject: [PATCH 10/10] arm: dts: lpc32xx: enable SIC1 and SIC2 by default
In-Reply-To: <1447982925-30138-1-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
Message-ID: <1447982925-30138-11-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After moving to a new LPC32xx interrupt controller driver it is safe
to enable SIC1 and SIC2 devices, this allows to get working ADC, RTC,
I2C and USB peripheral controllers again after long period since ...

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index 8dda6e7..603f005 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -341,8 +341,6 @@
 						 <&wakeup_int 24 20>, <&wakeup_int 29 8>,
 						 <&wakeup_int 30 6>, <&wakeup_int 31 7>,
 						 <&wakeup_pin 25 4>;
-
-				status = "disabled";
 			};
 
 			sic2: interrupt-controller at 40010000 {
@@ -369,8 +367,6 @@
 						 <&wakeup_pin 16 28>, <&wakeup_pin 18 18>,
 						 <&wakeup_pin 23 7>, <&wakeup_pin 26 19>,
 						 <&wakeup_pin 30 12>;
-
-				status = "disabled";
 			};
 
 			uart1: serial at 40014000 {
-- 
2.1.4
