From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 16 Sep 2014 10:43:57 +0200
Subject: [PATCH] ARM: at91/dt: sama5d3: add the nfc clock
Message-ID: <1410857037-24445-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atmel_nand driver is now able to handle the nfc clock, add it to sama5d3.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 7702a0d120cb..cd36c76fd4e3 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1005,6 +1005,11 @@
 						reg = <2>;
 					};
 
+					hsmc_clk: hsmc_clk {
+						#clock-cells = <0>;
+						reg = <5>;
+					};
+
 					pioA_clk: pioA_clk {
 						#clock-cells = <0>;
 						reg = <6>;
@@ -1405,6 +1410,7 @@
 					0xffffc000 0x00000070	/* NFC HSMC regs */
 					0x00200000 0x00100000	/* NFC SRAM banks */
 					>;
+				clocks = <&hsmc_clk>;
 			};
 		};
 	};
-- 
1.9.1
