From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 26 Sep 2016 09:22:11 +0200
Subject: [PATCH] ARM: dts: pxa: fix gpio0 and gpio1 interrupts
Message-ID: <1474874531-26703-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gpio-pxa was redesigned to differenciate gpio0, gpio1 and the
gpio-mux interrupt as in the hardware IP, the device-tree description
should be amended so that interrupts from gpio0 and gpio1 can be mapped
to consumers.

This is especially true on lubbock and mainstone devices where gpio0 is
multiplexed on pxa_cplds for ethernet, sa1111, usb udc, and other
devices.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 3ff077ca4400..e4ebcde17837 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -54,8 +54,8 @@
 			reg = <0x40e00000 0x10000>;
 			gpio-controller;
 			#gpio-cells = <0x2>;
-			interrupts = <10>;
-			interrupt-names = "gpio_mux";
+			interrupts = <8>, <9>, <10>;
+			interrupt-names = "gpio0", "gpio1", "gpio_mux";
 			interrupt-controller;
 			#interrupt-cells = <0x2>;
 			ranges;
-- 
2.1.4
