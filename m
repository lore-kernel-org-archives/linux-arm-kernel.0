From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:13 +0530
Subject: [PATCH 06/11] dts: define ngpios property in gpio controller's node
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-7-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ngpios property in cygnus ASIU, CCM and CRMU gpio controller's
node.

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 6621f13..d0fd050 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -64,6 +64,7 @@
 		compatible = "brcm,cygnus-crmu-gpio";
 		reg = <0x03024800 0x50>,
 		      <0x03024008 0x18>;
+		ngpios = <6>;
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
@@ -72,6 +73,7 @@
 		compatible = "brcm,cygnus-ccm-gpio";
 		reg = <0x1800a000 0x50>,
 		      <0x0301d164 0x20>;
+		ngpios = <24>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -81,6 +83,7 @@
 	gpio_asiu: gpio at 180a5000 {
 		compatible = "brcm,cygnus-asiu-gpio";
 		reg = <0x180a5000 0x668>;
+		ngpios = <146>;
 		#gpio-cells = <2>;
 		gpio-controller;
 
-- 
1.9.1
