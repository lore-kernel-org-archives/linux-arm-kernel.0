From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Jul 2016 01:07:28 +0200
Subject: [PATCH 2/4] ARM: dts: at91: Fix ADC trigger nodes
In-Reply-To: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468364850-32475-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The triggers don't need a reg property, remove it when prenset. Also remove
the unit-address from their name.

This solves:
Warning (unit_address_vs_reg): Node /ahb/apb/adc at fc034000/trigger at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /ahb/apb/adc at fc034000/trigger at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /ahb/apb/adc at fc034000/trigger at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /ahb/apb/adc at fc034000/trigger at 3 has a unit name, but no reg property

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 12 ++++--------
 arch/arm/boot/dts/at91sam9g45.dtsi | 12 ++++--------
 arch/arm/boot/dts/at91sam9rl.dtsi  | 12 ++++--------
 arch/arm/boot/dts/at91sam9x5.dtsi  | 12 ++++--------
 arch/arm/boot/dts/sama5d3.dtsi     | 12 ++++--------
 arch/arm/boot/dts/sama5d4.dtsi     |  8 ++++----
 6 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index af5ba315315f..49a02f5a4476 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -938,25 +938,21 @@
 				atmel,adc-res-names = "lowres", "highres";
 				atmel,adc-use-res = "highres";
 
-				trigger at 0 {
-					reg = <0>;
+				trigger0 {
 					trigger-name = "timer-counter-0";
 					trigger-value = <0x1>;
 				};
-				trigger at 1 {
-					reg = <1>;
+				trigger1 {
 					trigger-name = "timer-counter-1";
 					trigger-value = <0x3>;
 				};
 
-				trigger at 2 {
-					reg = <2>;
+				trigger2 {
 					trigger-name = "timer-counter-2";
 					trigger-value = <0x5>;
 				};
 
-				trigger at 3 {
-					reg = <3>;
+				trigger3 {
 					trigger-name = "external";
 					trigger-value = <0xd>;
 					trigger-external;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 8837b7e4292c..048a9815a9e5 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1044,28 +1044,24 @@
 				atmel,adc-res-names = "lowres", "highres";
 				atmel,adc-use-res = "highres";
 
-				trigger at 0 {
-					reg = <0>;
+				trigger0 {
 					trigger-name = "external-rising";
 					trigger-value = <0x1>;
 					trigger-external;
 				};
-				trigger at 1 {
-					reg = <1>;
+				trigger1 {
 					trigger-name = "external-falling";
 					trigger-value = <0x2>;
 					trigger-external;
 				};
 
-				trigger at 2 {
-					reg = <2>;
+				trigger2 {
 					trigger-name = "external-any";
 					trigger-value = <0x3>;
 					trigger-external;
 				};
 
-				trigger at 3 {
-					reg = <3>;
+				trigger3 {
 					trigger-name = "continuous";
 					trigger-value = <0x6>;
 				};
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 6d829db4e887..201a3ca56874 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -265,25 +265,21 @@
 				atmel,adc-res-names = "lowres", "highres";
 				atmel,adc-use-res = "highres";
 
-				trigger at 0 {
-					reg = <0>;
+				trigger0 {
 					trigger-name = "timer-counter-0";
 					trigger-value = <0x1>;
 				};
-				trigger at 1 {
-					reg = <1>;
+				trigger1 {
 					trigger-name = "timer-counter-1";
 					trigger-value = <0x3>;
 				};
 
-				trigger at 2 {
-					reg = <2>;
+				trigger2 {
 					trigger-name = "timer-counter-2";
 					trigger-value = <0x5>;
 				};
 
-				trigger at 3 {
-					reg = <3>;
+				trigger3 {
 					trigger-name = "external";
 					trigger-value = <0x13>;
 					trigger-external;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index cd0cd5fd09a3..075d5881770d 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -1048,29 +1048,25 @@
 				atmel,adc-res-names = "lowres", "highres";
 				atmel,adc-use-res = "highres";
 
-				trigger at 0 {
-					reg = <0>;
+				trigger0 {
 					trigger-name = "external-rising";
 					trigger-value = <0x1>;
 					trigger-external;
 				};
 
-				trigger at 1 {
-					reg = <1>;
+				trigger1 {
 					trigger-name = "external-falling";
 					trigger-value = <0x2>;
 					trigger-external;
 				};
 
-				trigger at 2 {
-					reg = <2>;
+				trigger2 {
 					trigger-name = "external-any";
 					trigger-value = <0x3>;
 					trigger-external;
 				};
 
-				trigger at 3 {
-					reg = <3>;
+				trigger3 {
 					trigger-name = "continuous";
 					trigger-value = <0x6>;
 				};
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 36301bd9a14a..a7c5cf4d4ea5 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -326,26 +326,22 @@
 				atmel,adc-res-names = "lowres", "highres";
 				status = "disabled";
 
-				trigger at 0 {
-					reg = <0>;
+				trigger0 {
 					trigger-name = "external-rising";
 					trigger-value = <0x1>;
 					trigger-external;
 				};
-				trigger at 1 {
-					reg = <1>;
+				trigger1 {
 					trigger-name = "external-falling";
 					trigger-value = <0x2>;
 					trigger-external;
 				};
-				trigger at 2 {
-					reg = <2>;
+				trigger2 {
 					trigger-name = "external-any";
 					trigger-value = <0x3>;
 					trigger-external;
 				};
-				trigger at 3 {
-					reg = <3>;
+				trigger3 {
 					trigger-name = "continuous";
 					trigger-value = <0x6>;
 				};
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 4e2cc30d6615..5a9f50fb8d65 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1226,22 +1226,22 @@
 				atmel,adc-ts-pressure-threshold = <10000>;
 				status = "disabled";
 
-				trigger at 0 {
+				trigger0 {
 					trigger-name = "external-rising";
 					trigger-value = <0x1>;
 					trigger-external;
 				};
-				trigger at 1 {
+				trigger1 {
 					trigger-name = "external-falling";
 					trigger-value = <0x2>;
 					trigger-external;
 				};
-				trigger at 2 {
+				trigger2 {
 					trigger-name = "external-any";
 					trigger-value = <0x3>;
 					trigger-external;
 				};
-				trigger at 3 {
+				trigger3 {
 					trigger-name = "continuous";
 					trigger-value = <0x6>;
 				};
-- 
2.8.1
