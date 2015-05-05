From: eric@anholt.net (Eric Anholt)
Date: Tue,  5 May 2015 13:27:46 -0700
Subject: [PATCH 3/3 v2] ARM: bcm2835: Add the mailbox to the device tree
In-Reply-To: <1430857666-18877-1-git-send-email-eric@anholt.net>
References: <1430857666-18877-1-git-send-email-eric@anholt.net>
Message-ID: <1430857666-18877-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---

v2: Update for #mbox-cells 0 change in the driver.

 arch/arm/boot/dts/bcm2835.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 4d4c129..4ff1b83 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -61,6 +61,13 @@
 			reg = <0x7e104000 0x10>;
 		};
 
+		mailbox: mailbox at 7e00b800 {
+			compatible = "brcm,bcm2835-mbox";
+			reg = <0x7e00b880 0x40>;
+			interrupts = <0 1>;
+			#mbox-cells = <0>;
+		};
+
 		gpio: gpio at 7e200000 {
 			compatible = "brcm,bcm2835-gpio";
 			reg = <0x7e200000 0xb4>;
-- 
2.1.4
