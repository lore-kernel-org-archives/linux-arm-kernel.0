From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Wed, 25 Jan 2017 16:27:01 -0800
Subject: [PATCH v3 3/4] ARM: dts: Remove Broadcom iProc mailbox controller node
In-Reply-To: <1485390422-3984-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1485390422-3984-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1485390422-3984-4-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox controller node and crmu gpio driver changes to enable
interrupt support were prematurely merged and don't reflect the mailbox
controller driver. They are being reverted.

Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 8833a4c..cf02271 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -121,15 +121,6 @@
 			      <0x0301d24c 0x2c>;
 		};
 
-		mailbox: mailbox at 03024024 {
-			compatible = "brcm,iproc-mailbox";
-			reg = <0x03024024 0x40>;
-			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			#mbox-cells = <1>;
-		};
-
 		gpio_crmu: gpio at 03024800 {
 			compatible = "brcm,cygnus-crmu-gpio";
 			reg = <0x03024800 0x50>,
@@ -137,9 +128,6 @@
 			ngpios = <6>;
 			#gpio-cells = <2>;
 			gpio-controller;
-			interrupt-controller;
-			interrupt-parent = <&mailbox>;
-			interrupts = <0>;
 		};
 
 		i2c0: i2c at 18008000 {
-- 
1.9.1
