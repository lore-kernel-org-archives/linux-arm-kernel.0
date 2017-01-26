From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Thu, 26 Jan 2017 12:38:02 -0800
Subject: [PATCH v4 3/3] ARM: dts: Enable Broadcom iProc mailbox controller
In-Reply-To: <1485463082-27067-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1485463082-27067-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1485463082-27067-4-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for iProc mailbox controller and enable. Proposed changes to
add interrupt support to the mailbox controller and gpio crmu driver
were prematurely merged into the mainline. Those changes are reverted in
this commit.

Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 8833a4c..606e11a 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -123,10 +123,7 @@
 
 		mailbox: mailbox at 03024024 {
 			compatible = "brcm,iproc-mailbox";
-			reg = <0x03024024 0x40>;
-			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
+			reg = <0x03024024 0x8>;
 			#mbox-cells = <1>;
 		};
 
@@ -137,9 +134,6 @@
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
