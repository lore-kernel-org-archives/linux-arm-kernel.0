From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 29 Mar 2013 10:13:19 +0100
Subject: [PATCH] ARM: at91: dts: add adc resolution stuff
Message-ID: <1364548399-15827-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add the ADC low and high resolution configuration and which one to use.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi,

This patch is a split from this set of patches:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/206130/focus=6321

Then device tree changes can go through ARM-SOC and driver changes through the
iio subsystem.

Regards

Ludovic

 arch/arm/boot/dts/at91sam9260.dtsi | 3 +++
 arch/arm/boot/dts/at91sam9g45.dtsi | 3 +++
 arch/arm/boot/dts/at91sam9x5.dtsi  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index cb7bcc5..367a604 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -484,6 +484,9 @@
 				atmel,adc-drdy-mask = <0x10000>;
 				atmel,adc-status-register = <0x1c>;
 				atmel,adc-trigger-register = <0x04>;
+				atmel,adc-res = <8 10>;
+				atmel,adc-res-names = "lowres", "highres";
+				atmel,adc-use-res = "highres";
 
 				trigger at 0 {
 					trigger-name = "timer-counter-0";
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 6b1d4ca..0fa28af 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -484,6 +484,9 @@
 				atmel,adc-drdy-mask = <0x10000>;
 				atmel,adc-status-register = <0x1c>;
 				atmel,adc-trigger-register = <0x08>;
+				atmel,adc-res = <8 10>;
+				atmel,adc-res-names = "lowres", "highres";
+				atmel,adc-use-res = "highres";
 
 				trigger at 0 {
 					trigger-name = "external-rising";
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index a98c0d5..08bcdd7 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -505,6 +505,9 @@
 				atmel,adc-drdy-mask = <0x1000000>;
 				atmel,adc-status-register = <0x30>;
 				atmel,adc-trigger-register = <0xc0>;
+				atmel,adc-res = <8 10>;
+				atmel,adc-res-names = "lowres", "highres";
+				atmel,adc-use-res = "highres";
 
 				trigger at 0 {
 					trigger-name = "external-rising";
-- 
1.7.11.3
