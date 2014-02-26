From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Feb 2014 18:01:11 +0100
Subject: [PATCH 4/7] ARM: at91/dt: at91sam9260: remove useless adc properties
In-Reply-To: <1393434074-15600-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1393434074-15600-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1393434074-15600-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the properties that are not used anymore by the at91_adc driver.

Also, stop using unit-addresses for the triggers as suggested by Mark
Rutland in
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/234184.html

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 997901f7ed73..ac1533368cb5 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -614,31 +614,26 @@
 				atmel,adc-use-external-triggers;
 				atmel,adc-channels-used = <0xf>;
 				atmel,adc-vref = <3300>;
-				atmel,adc-num-channels = <4>;
 				atmel,adc-startup-time = <15>;
-				atmel,adc-channel-base = <0x30>;
-				atmel,adc-drdy-mask = <0x10000>;
-				atmel,adc-status-register = <0x1c>;
-				atmel,adc-trigger-register = <0x04>;
 				atmel,adc-res = <8 10>;
 				atmel,adc-res-names = "lowres", "highres";
 				atmel,adc-use-res = "highres";
 
-				trigger at 0 {
+				trigger0 {
 					trigger-name = "timer-counter-0";
 					trigger-value = <0x1>;
 				};
-				trigger at 1 {
+				trigger1 {
 					trigger-name = "timer-counter-1";
 					trigger-value = <0x3>;
 				};
 
-				trigger at 2 {
+				trigger2 {
 					trigger-name = "timer-counter-2";
 					trigger-value = <0x5>;
 				};
 
-				trigger at 3 {
+				trigger3 {
 					trigger-name = "external";
 					trigger-value = <0x13>;
 					trigger-external;
-- 
1.8.3.2
