From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Jul 2016 01:07:30 +0200
Subject: [PATCH 4/4] ARM: dts: at91: Fix USB endpoint nodes
In-Reply-To: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468364850-32475-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Endpoint nodes have a reg property. Add their mandatory unit-address.

This solves:
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep0 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep1 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep2 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep3 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep4 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep5 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep6 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep7 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep8 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep9 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep10 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep11 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep12 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep13 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep14 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /ahb/gadget at 00400000/ep15 has a reg or ranges property, but no unit name

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 14 +++++++-------
 arch/arm/boot/dts/at91sam9rl.dtsi  | 14 +++++++-------
 arch/arm/boot/dts/at91sam9x5.dtsi  | 14 +++++++-------
 arch/arm/boot/dts/sama5d2.dtsi     | 32 ++++++++++++++++----------------
 arch/arm/boot/dts/sama5d3.dtsi     | 32 ++++++++++++++++----------------
 arch/arm/boot/dts/sama5d4.dtsi     | 32 ++++++++++++++++----------------
 6 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 048a9815a9e5..c8789a8a0a1d 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1165,13 +1165,13 @@
 				clock-names = "pclk", "hclk";
 				status = "disabled";
 
-				ep0 {
+				ep at 0 {
 					reg = <0>;
 					atmel,fifo-size = <64>;
 					atmel,nb-banks = <1>;
 				};
 
-				ep1 {
+				ep at 1 {
 					reg = <1>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <2>;
@@ -1179,7 +1179,7 @@
 					atmel,can-isoc;
 				};
 
-				ep2 {
+				ep at 2 {
 					reg = <2>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <2>;
@@ -1187,21 +1187,21 @@
 					atmel,can-isoc;
 				};
 
-				ep3 {
+				ep at 3 {
 					reg = <3>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
 					atmel,can-dma;
 				};
 
-				ep4 {
+				ep at 4 {
 					reg = <4>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
 					atmel,can-dma;
 				};
 
-				ep5 {
+				ep at 5 {
 					reg = <5>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
@@ -1209,7 +1209,7 @@
 					atmel,can-isoc;
 				};
 
-				ep6 {
+				ep at 6 {
 					reg = <6>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 201a3ca56874..cdaae8eb038c 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -297,13 +297,13 @@
 				clock-names = "pclk", "hclk";
 				status = "disabled";
 
-				ep0 {
+				ep at 0 {
 					reg = <0>;
 					atmel,fifo-size = <64>;
 					atmel,nb-banks = <1>;
 				};
 
-				ep1 {
+				ep at 1 {
 					reg = <1>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <2>;
@@ -311,7 +311,7 @@
 					atmel,can-isoc;
 				};
 
-				ep2 {
+				ep at 2 {
 					reg = <2>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <2>;
@@ -319,21 +319,21 @@
 					atmel,can-isoc;
 				};
 
-				ep3 {
+				ep at 3 {
 					reg = <3>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
 					atmel,can-dma;
 				};
 
-				ep4 {
+				ep at 4 {
 					reg = <4>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
 					atmel,can-dma;
 				};
 
-				ep5 {
+				ep at 5 {
 					reg = <5>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
@@ -341,7 +341,7 @@
 					atmel,can-isoc;
 				};
 
-				ep6 {
+				ep at 6 {
 					reg = <6>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 075d5881770d..f14ed909236c 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -1115,13 +1115,13 @@
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 
-				ep0 {
+				ep at 0 {
 					reg = <0>;
 					atmel,fifo-size = <64>;
 					atmel,nb-banks = <1>;
 				};
 
-				ep1 {
+				ep at 1 {
 					reg = <1>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <2>;
@@ -1129,7 +1129,7 @@
 					atmel,can-isoc;
 				};
 
-				ep2 {
+				ep at 2 {
 					reg = <2>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <2>;
@@ -1137,21 +1137,21 @@
 					atmel,can-isoc;
 				};
 
-				ep3 {
+				ep at 3 {
 					reg = <3>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
 					atmel,can-dma;
 				};
 
-				ep4 {
+				ep at 4 {
 					reg = <4>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
 					atmel,can-dma;
 				};
 
-				ep5 {
+				ep at 5 {
 					reg = <5>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
@@ -1159,7 +1159,7 @@
 					atmel,can-isoc;
 				};
 
-				ep6 {
+				ep at 6 {
 					reg = <6>;
 					atmel,fifo-size = <1024>;
 					atmel,nb-banks = <3>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 5d63206aab91..c885d2b153ca 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -117,13 +117,13 @@
 			clock-names = "pclk", "hclk";
 			status = "disabled";
 
-			ep0 {
+			ep at 0 {
 				reg = <0>;
 				atmel,fifo-size = <64>;
 				atmel,nb-banks = <1>;
 			};
 
-			ep1 {
+			ep at 1 {
 				reg = <1>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <3>;
@@ -131,7 +131,7 @@
 				atmel,can-isoc;
 			};
 
-			ep2 {
+			ep at 2 {
 				reg = <2>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <3>;
@@ -139,7 +139,7 @@
 				atmel,can-isoc;
 			};
 
-			ep3 {
+			ep at 3 {
 				reg = <3>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -147,7 +147,7 @@
 				atmel,can-isoc;
 			};
 
-			ep4 {
+			ep at 4 {
 				reg = <4>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -155,7 +155,7 @@
 				atmel,can-isoc;
 			};
 
-			ep5 {
+			ep at 5 {
 				reg = <5>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -163,7 +163,7 @@
 				atmel,can-isoc;
 			};
 
-			ep6 {
+			ep at 6 {
 				reg = <6>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -171,7 +171,7 @@
 				atmel,can-isoc;
 			};
 
-			ep7 {
+			ep at 7 {
 				reg = <7>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -179,56 +179,56 @@
 				atmel,can-isoc;
 			};
 
-			ep8 {
+			ep at 8 {
 				reg = <8>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep9 {
+			ep at 9 {
 				reg = <9>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep10 {
+			ep at 10 {
 				reg = <10>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep11 {
+			ep at 11 {
 				reg = <11>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep12 {
+			ep at 12 {
 				reg = <12>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep13 {
+			ep at 13 {
 				reg = <13>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep14 {
+			ep at 14 {
 				reg = <14>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep15 {
+			ep at 15 {
 				reg = <15>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index a7c5cf4d4ea5..4c84d333fc7e 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1337,13 +1337,13 @@
 			clock-names = "pclk", "hclk";
 			status = "disabled";
 
-			ep0 {
+			ep at 0 {
 				reg = <0>;
 				atmel,fifo-size = <64>;
 				atmel,nb-banks = <1>;
 			};
 
-			ep1 {
+			ep at 1 {
 				reg = <1>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <3>;
@@ -1351,7 +1351,7 @@
 				atmel,can-isoc;
 			};
 
-			ep2 {
+			ep at 2 {
 				reg = <2>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <3>;
@@ -1359,84 +1359,84 @@
 				atmel,can-isoc;
 			};
 
-			ep3 {
+			ep at 3 {
 				reg = <3>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-dma;
 			};
 
-			ep4 {
+			ep at 4 {
 				reg = <4>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-dma;
 			};
 
-			ep5 {
+			ep at 5 {
 				reg = <5>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-dma;
 			};
 
-			ep6 {
+			ep at 6 {
 				reg = <6>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-dma;
 			};
 
-			ep7 {
+			ep at 7 {
 				reg = <7>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-dma;
 			};
 
-			ep8 {
+			ep at 8 {
 				reg = <8>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 			};
 
-			ep9 {
+			ep at 9 {
 				reg = <9>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 			};
 
-			ep10 {
+			ep at 10 {
 				reg = <10>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 			};
 
-			ep11 {
+			ep at 11 {
 				reg = <11>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 			};
 
-			ep12 {
+			ep at 12 {
 				reg = <12>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 			};
 
-			ep13 {
+			ep at 13 {
 				reg = <13>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 			};
 
-			ep14 {
+			ep at 14 {
 				reg = <14>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 			};
 
-			ep15 {
+			ep at 15 {
 				reg = <15>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 5a9f50fb8d65..65e725fb5679 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -135,13 +135,13 @@
 			clock-names = "pclk", "hclk";
 			status = "disabled";
 
-			ep0 {
+			ep at 0 {
 				reg = <0>;
 				atmel,fifo-size = <64>;
 				atmel,nb-banks = <1>;
 			};
 
-			ep1 {
+			ep at 1 {
 				reg = <1>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <3>;
@@ -149,7 +149,7 @@
 				atmel,can-isoc;
 			};
 
-			ep2 {
+			ep at 2 {
 				reg = <2>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <3>;
@@ -157,7 +157,7 @@
 				atmel,can-isoc;
 			};
 
-			ep3 {
+			ep at 3 {
 				reg = <3>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -165,7 +165,7 @@
 				atmel,can-isoc;
 			};
 
-			ep4 {
+			ep at 4 {
 				reg = <4>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -173,7 +173,7 @@
 				atmel,can-isoc;
 			};
 
-			ep5 {
+			ep at 5 {
 				reg = <5>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -181,7 +181,7 @@
 				atmel,can-isoc;
 			};
 
-			ep6 {
+			ep at 6 {
 				reg = <6>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -189,7 +189,7 @@
 				atmel,can-isoc;
 			};
 
-			ep7 {
+			ep at 7 {
 				reg = <7>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
@@ -197,56 +197,56 @@
 				atmel,can-isoc;
 			};
 
-			ep8 {
+			ep at 8 {
 				reg = <8>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep9 {
+			ep at 9 {
 				reg = <9>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep10 {
+			ep at 10 {
 				reg = <10>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep11 {
+			ep at 11 {
 				reg = <11>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep12 {
+			ep at 12 {
 				reg = <12>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep13 {
+			ep at 13 {
 				reg = <13>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep14 {
+			ep at 14 {
 				reg = <14>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
 				atmel,can-isoc;
 			};
 
-			ep15 {
+			ep at 15 {
 				reg = <15>;
 				atmel,fifo-size = <1024>;
 				atmel,nb-banks = <2>;
-- 
2.8.1
