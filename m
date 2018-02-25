From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 25 Feb 2018 15:10:53 +0100
Subject: [PATCH 2/4] ARM: dts: bcm283x: Apply pull settings to Zero W relevant
 groups
In-Reply-To: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1519567855-26105-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of keeping the firmware's pull settings, we better apply
them via the devicetree pin control. Start with the RPi Zero W relevant
first to keep the effort low.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm283x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 8d9a0df..1a50b67 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -223,6 +223,7 @@
 			gpclk2_gpio43: gpclk2_gpio43 {
 				brcm,pins = <43>;
 				brcm,function = <BCM2835_FSEL_ALT0>;
+				brcm,pull = <BCM2835_PUD_OFF>;
 			};
 
 			i2c0_gpio0: i2c0_gpio0 {
@@ -335,10 +336,12 @@
 			uart0_ctsrts_gpio30: uart0_ctsrts_gpio30 {
 				brcm,pins = <30 31>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
+				brcm,pull = <BCM2835_PUD_UP BCM2835_PUD_OFF>;
 			};
 			uart0_gpio32: uart0_gpio32 {
 				brcm,pins = <32 33>;
 				brcm,function = <BCM2835_FSEL_ALT3>;
+				brcm,pull = <BCM2835_PUD_OFF BCM2835_PUD_UP>;
 			};
 			uart0_gpio36: uart0_gpio36 {
 				brcm,pins = <36 37>;
-- 
2.7.4
