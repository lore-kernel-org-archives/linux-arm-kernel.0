From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 24 Oct 2014 15:20:05 +0200
Subject: [PATCH] bcm2835: add VideoCore Mailbox to the device tree
Message-ID: <1414156805-30253-1-git-send-email-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follows the generic Mailbox Controller bindings as documented in
Documentation/devicetree/bindings/mailbox/mailbox.txt.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/bcm2835.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 3342cb1..bd046a9 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -50,6 +50,13 @@
 			#interrupt-cells = <2>;
 		};
 
+		mailbox: mailbox at 0x7e00b880 {
+			compatible = "brcm,bcm2835-mbox";
+			reg = <0x7e00b880 0x40>;
+			interrupts = <0 1>;
+			#mbox-cells = <1>;
+		};
+
 		watchdog at 7e100000 {
 			compatible = "brcm,bcm2835-pm-wdt";
 			reg = <0x7e100000 0x28>;
-- 
2.1.0
