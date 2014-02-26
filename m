From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Feb 2014 18:01:12 +0100
Subject: [PATCH 5/7] ARM: at91/dt: at91sam9g45: remove useless adc properties
In-Reply-To: <1393434074-15600-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1393434074-15600-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1393434074-15600-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the properties that are not used anymore by the at91_adc driver.

Also, stop using unit-addresses for the triggers as suggested by Mark
Rutland in
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/234184.html

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index cbcc058b26b4..715187692577 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -638,34 +638,29 @@
 				atmel,adc-use-external-triggers;
 				atmel,adc-channels-used = <0xff>;
 				atmel,adc-vref = <3300>;
-				atmel,adc-num-channels = <8>;
 				atmel,adc-startup-time = <40>;
-				atmel,adc-channel-base = <0x30>;
-				atmel,adc-drdy-mask = <0x10000>;
-				atmel,adc-status-register = <0x1c>;
-				atmel,adc-trigger-register = <0x08>;
 				atmel,adc-res = <8 10>;
 				atmel,adc-res-names = "lowres", "highres";
 				atmel,adc-use-res = "highres";
 
-				trigger at 0 {
+				trigger0 {
 					trigger-name = "external-rising";
 					trigger-value = <0x1>;
 					trigger-external;
 				};
-				trigger at 1 {
+				trigger1 {
 					trigger-name = "external-falling";
 					trigger-value = <0x2>;
 					trigger-external;
 				};
 
-				trigger at 2 {
+				trigger2 {
 					trigger-name = "external-any";
 					trigger-value = <0x3>;
 					trigger-external;
 				};
 
-				trigger at 3 {
+				trigger3 {
 					trigger-name = "continuous";
 					trigger-value = <0x6>;
 				};
-- 
1.8.3.2
