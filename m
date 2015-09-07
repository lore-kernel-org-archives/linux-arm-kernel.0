From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon,  7 Sep 2015 17:22:08 +0200
Subject: [PATCH] ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx,
 clear pullup on tx
Message-ID: <1441639328-2615-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove pullup on dbgu DTXD signal, it is a push-pull output thus the
pullup only increase power consumption while transmitting with no value
added.

Add pullup on dbgu DRXD signal, it prevents the DRXD signal to be left
floating and so consuming a useless extra amount of power if nothing is
externally connected to dbgu.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  | 4 ++--
 arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9261.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9263.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9rl.dtsi  | 4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
 arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
 arch/arm/boot/dts/sama5d4.dtsi     | 4 ++--
 10 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 60edd8b..12815f6d 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -481,8 +481,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA30 periph A */
-							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA31 periph with pullup */
+							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA30 periph A with pullup */
+							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA31 periph */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index be9c027..f33902d 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -412,8 +412,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOB 14 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB14 periph A */
-							 AT91_PIOB 15 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PB15 periph with pullup */
+							<AT91_PIOB 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB14 periph A with pullup */
+							 AT91_PIOB 15 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB15 periph */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index ce1e3e9..f667bb9 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -302,8 +302,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOA 9  AT91_PERIPH_A AT91_PINCTRL_NONE>,
-							<AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+							<AT91_PIOA 9  AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
+							<AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index f1f5fa3..97a501a 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -412,8 +412,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PC30 periph A */
-							 AT91_PIOC 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PC31 periph with pullup */
+							<AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PC30 periph A with pullup */
+							 AT91_PIOC 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PC31 periph */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 18b8b9e..41b87b6 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -478,7 +478,7 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB12 periph A */
+							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB12 periph A with pullup */
 							 AT91_PIOB 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB13 periph A */
 					};
 				};
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 32bc9a1..48dc782 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -500,8 +500,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA9 periph A */
-							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA10 periph with pullup */
+							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA9 periph A with pullup */
+							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA10 periph */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index a0b90ae..ec14c9e 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -442,8 +442,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOA 21 AT91_PERIPH_A AT91_PINCTRL_NONE>,
-							<AT91_PIOA 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+							<AT91_PIOA 21 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
+							<AT91_PIOA 22 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 747d8f0..92378a7 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -460,8 +460,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA9 periph A */
-							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA10 periph A with pullup */
+							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA9 periph A with pullup */
+							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA10 periph A */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 7fa2765..ad686673 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -545,8 +545,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB30 periph A */
-							 AT91_PIOB 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PB31 periph A with pullup */
+							<AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB30 periph A with pullup */
+							 AT91_PIOB 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB31 periph A */
 					};
 				};
 
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 8d1de29..76f06e0 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1441,8 +1441,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_NONE>,     /* conflicts with D14 and TDI */
-							<AT91_PIOB 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;  /* conflicts with D15 and TDO */
+							<AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* conflicts with D14 and TDI */
+							 AT91_PIOB 25 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* conflicts with D15 and TDO */
 					};
 				};
 
-- 
2.5.1
