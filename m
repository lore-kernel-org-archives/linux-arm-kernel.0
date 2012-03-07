From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 10:15:43 +0100
Subject: [PATCH 6/9] ARM: at91: sam9g20 udc add dt support
In-Reply-To: <20120307084924.GK21255@game.jcrosoft.org>
References: <20120307084924.GK21255@game.jcrosoft.org>
Message-ID: <1331111746-21393-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi |    7 +++++++
 arch/arm/boot/dts/usb_a9g20.dts    |    5 +++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 8c5c175..c030703 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -171,6 +171,13 @@
 				interrupts = <21 4>;
 				status = "disabled";
 			};
+
+			usb1: gadget at fffa4000 {
+				compatible = "atmel,at91rm9200-udc";
+				reg = <0xfffa4000 0x4000>;
+				interrupts = <10 4>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 55d0e54..e4a732f 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -30,6 +30,11 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			usb1: gadget at fffa4000 {
+				atmel,vbus-gpio = <&pioC 5 0>;
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.7
