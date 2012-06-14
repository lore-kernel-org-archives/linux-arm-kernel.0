From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:07 +0200
Subject: [PATCH v2 17/23] ARM: LPC32xx: Add dt settings to the at25 node
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-18-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Add the reg, cs-gpios and max-frequencies that are needed for spi
device registry in phy3250.
Adds also the pl022 internal transfers details via dt

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/boot/dts/phy3250.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- linux-2.6.orig/arch/arm/boot/dts/phy3250.dts
+++ linux-2.6/arch/arm/boot/dts/phy3250.dts
@@ -133,8 +133,29 @@
 			};
 
 			ssp0: ssp at 20084000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pl022,num-chipselects = <1>;
+				cs-gpios = <&gpio 3 5 0>;
+
 				eeprom: at25 at 0 {
+					pl022,hierarchy = <0>;
+					pl022,interface = <0>;
+					pl022,slave-tx-disable = <0>;
+					pl022,com-mode = <0>;
+					pl022,rx-level-trig = <1>;
+					pl022,tx-level-trig = <1>;
+					pl022,ctrl-len = <11>;
+					pl022,wait-state = <0>;
+					pl022,duplex = <0>;
+
+					at25,byte-len = <0x8000>;
+					at25,addr-mode = <2>;
+					at25,page-size = <64>;
+
 					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <5000000>;
 				};
 			};
 
