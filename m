From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 16 Oct 2016 18:21:45 +0200
Subject: [PATCH v2] ARM: at91/dt: fixes dbgu pinctrl, set pullup on rx,
 clear pullup on tx
In-Reply-To: <20161016162145.26193-1-sylvain.rochet@finsecur.com>
References: <20161016162145.26193-1-sylvain.rochet@finsecur.com>
Message-ID: <20161016162145.26193-2-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove pullup on dbgu DTXD signal, it is a push-pull output thus the
pullup is pointless.

Add pullup on dbgu DRXD signal, it prevents the DRXD signal to be left
floating and so consuming a useless extra amount of power in crowbarred
state if nothing is externally connected to dbgu.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  | 4 ++--
 arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9261.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9263.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9g45.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9n12.dtsi | 4 ++--
 arch/arm/boot/dts/at91sam9rl.dtsi  | 4 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
 arch/arm/boot/dts/sama5d3.dtsi     | 4 ++--
 arch/arm/boot/dts/sama5d4.dtsi     | 4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 4e913c2..f057e0b 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -481,8 +481,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA30 periph A */
-							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA31 periph with pullup */
+							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index a3e363d..9e035b2 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -412,8 +412,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOB 14 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB14 periph A */
-							 AT91_PIOB 15 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PB15 periph with pullup */
+							<AT91_PIOB 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOB 15 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 32752d7..3fe77c3 100644
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
index aeb1a36..a1888f6 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -412,8 +412,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PC30 periph A */
-							 AT91_PIOC 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PC31 periph with pullup */
+							<AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOC 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index b3501ae..e567d5f 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -478,8 +478,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB12 periph A */
-							 AT91_PIOB 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB13 periph A */
+							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOB 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 3b3eb3e..f43d769 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -500,8 +500,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA9 periph A */
-							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA10 periph with pullup */
+							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 70adf94..f4c129a 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -438,8 +438,8 @@
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
index ed4e4bd..f66bae9 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -460,8 +460,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA9 periph A */
-							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA10 periph A with pullup */
+							<AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 4c84d33..b06448b 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -549,8 +549,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB30 periph A */
-							 AT91_PIOB 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PB31 periph A with pullup */
+							<AT91_PIOB 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOB 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 65e725f..d136ebd 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1461,8 +1461,8 @@
 				dbgu {
 					pinctrl_dbgu: dbgu-0 {
 						atmel,pins =
-							<AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_NONE>,     /* conflicts with D14 and TDI */
-							<AT91_PIOB 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;  /* conflicts with D15 and TDO */
+							<AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOB 25 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 				};
 
-- 
2.9.3
