From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 13:02:10 +0200
Subject: [PATCH 7/14] ARM: LPC32xx: DTS adjustment for key matrix controller
In-Reply-To: <1339412537-24485-1-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
Message-ID: <1339412537-24485-8-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch connects the lpc32xx-key driver to the LPC32xx platform (via
lpc32xx.dtsi), and more specifically to the reference board via its dts file.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Rob Herring <rob.herring@calxeda.com>

---

 arch/arm/boot/dts/lpc32xx.dtsi |    2 ++
 arch/arm/boot/dts/phy3250.dts  |    9 +++++++++
 2 files changed, 11 insertions(+)

--- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
+++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
@@ -249,6 +249,8 @@
 			key at 40050000 {
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
+				interrupts = <54 0>;
+				status = "disable";
 			};
 
 		};
--- linux-2.6.orig/arch/arm/boot/dts/phy3250.dts
+++ linux-2.6/arch/arm/boot/dts/phy3250.dts
@@ -135,6 +135,15 @@
 			tsc at 40048000 {
 				status = "okay";
 			};
+
+			key at 40050000 {
+				status = "okay";
+				keypad,num-rows = <1>;
+				keypad,num-columns = <1>;
+				nxp,debounce-delay-ms = <3>;
+				nxp,scan-delay-ms = <34>;
+				linux,keymap = <0x00000002>;
+			};
 		};
 	};
 
