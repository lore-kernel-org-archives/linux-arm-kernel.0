From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 28 Sep 2010 22:13:47 +0200
Subject: [PATCH 3/5] ARM: imx: make all pin lists const and signed,
	move to .init where possible
In-Reply-To: <20100928201230.GJ26352@pengutronix.de>
References: <20100928201230.GJ26352@pengutronix.de>
Message-ID: <1285704829-29406-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Making the lists signed fixes sparse warnings like:

	arch/arm/mach-imx/mach-mx27_3ds.c:94:31: warning: incorrect type in argument 1 (different signedness)
	arch/arm/mach-imx/mach-mx27_3ds.c:94:31:    expected int const *pin_list
	arch/arm/mach-imx/mach-mx27_3ds.c:94:31:    got unsigned int static [toplevel] *<noident>

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    2 +-
 arch/arm/mach-imx/mach-cpuimx27.c            |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    2 +-
 arch/arm/mach-imx/mach-imx27lite.c           |    2 +-
 arch/arm/mach-imx/mach-mx1ads.c              |    2 +-
 arch/arm/mach-imx/mach-mx21ads.c             |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c             |    2 +-
 arch/arm/mach-imx/mach-mxt_td60.c            |    2 +-
 arch/arm/mach-imx/mach-pca100.c              |    2 +-
 arch/arm/mach-imx/mach-pcm038.c              |    2 +-
 arch/arm/mach-imx/mach-scb9328.c             |    2 +-
 arch/arm/mach-imx/pcm970-baseboard.c         |    2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index cb433ae..026263c6 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -41,7 +41,7 @@
 #include "devices-imx27.h"
 #include "devices.h"
 
-static int eukrea_mbimx27_pins[] = {
+static const int eukrea_mbimx27_pins[] __initconst = {
 	/* UART2 */
 	PE3_PF_UART2_CTS,
 	PE4_PF_UART2_RTS,
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index f00ddd9..d4cb592 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -46,7 +46,7 @@
 #include "devices-imx27.h"
 #include "devices.h"
 
-static int eukrea_cpuimx27_pins[] = {
+static const int eukrea_cpuimx27_pins[] __initconst = {
 	/* UART1 */
 	PE12_PF_UART1_TXD,
 	PE13_PF_UART1_RXD,
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 7b3eed0..21904f3 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -44,7 +44,7 @@
 #define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
 #define SDHC1_IRQ IRQ_GPIOB(25)
 
-static int visstrim_m10_pins[] = {
+static const int visstrim_m10_pins[] __initconst = {
 	/* UART1 (console) */
 	PE12_PF_UART1_TXD,
 	PE13_PF_UART1_RXD,
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index 22a2b5d..67480b6 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -27,7 +27,7 @@
 #include "devices-imx27.h"
 #include "devices.h"
 
-static unsigned int mx27lite_pins[] = {
+static const int mx27lite_pins[] __initconst = {
 	/* UART1 */
 	PE12_PF_UART1_TXD,
 	PE13_PF_UART1_RXD,
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 6e2f249..85e2877 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -32,7 +32,7 @@
 #include "devices-imx1.h"
 #include "devices.h"
 
-static int mx1ads_pins[] = {
+static const int mx1ads_pins[] __initconst = {
 	/* UART1 */
 	PC9_PF_UART1_CTS,
 	PC10_PF_UART1_RTS,
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 96d7f81..7f021e6 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -67,7 +67,7 @@
 #define MX21ADS_IO_LED4_ON      0x4000
 #define MX21ADS_IO_LED3_ON      0x8000
 
-static unsigned int mx21ads_pins[] = {
+static const int mx21ads_pins[] __initconst = {
 
 	/* CS8900A */
 	(GPIO_PORTE | GPIO_GPIO | GPIO_IN | 11),
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index e66ffaa..9f6832d 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -33,7 +33,7 @@
 #include "devices-imx27.h"
 #include "devices.h"
 
-static unsigned int mx27pdk_pins[] = {
+static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
 	PE12_PF_UART1_TXD,
 	PE13_PF_UART1_RXD,
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 6be6033..1a33288 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -66,7 +66,7 @@
 /* to determine the correct external crystal reference */
 #define CKIH_27MHZ_BIT_SET      (1 << 3)
 
-static unsigned int mx27ads_pins[] = {
+static const int mx27ads_pins[] __initconst = {
 	/* UART0 */
 	PE12_PF_UART1_TXD,
 	PE13_PF_UART1_RXD,
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index d878bb9..58fb0d6 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -37,7 +37,7 @@
 #include "devices-imx27.h"
 #include "devices.h"
 
-static unsigned int mxt_td60_pins[] __initdata = {
+static const int mxt_td60_pins[] __initconst = {
 	/* UART0 */
 	PE12_PF_UART1_TXD,
 	PE13_PF_UART1_RXD,
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index cccf521..197dbb8 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -54,7 +54,7 @@
 #define SPI1_SS1 (GPIO_PORTD + 27)
 #define SD2_CD (GPIO_PORTC + 29)
 
-static int pca100_pins[] = {
+static const int pca100_pins[] __initconst = {
 	/* UART1 */
 	PE12_PF_UART1_TXD,
 	PE13_PF_UART1_RXD,
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index a3d645f..3fbed66 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -43,7 +43,7 @@
 #include "devices-imx27.h"
 #include "devices.h"
 
-static int pcm038_pins[] = {
+static const int pcm038_pins[] __initconst = {
 	/* UART1 */
 	PE12_PF_UART1_TXD,
 	PE13_PF_UART1_RXD,
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index 88bf0d1..fb2e5f3 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -95,7 +95,7 @@ static struct platform_device dm9000x_device = {
 	}
 };
 
-static int mxc_uart1_pins[] = {
+static const int mxc_uart1_pins[] = {
 	PC9_PF_UART1_CTS,
 	PC10_PF_UART1_RTS,
 	PC11_PF_UART1_TXD,
diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index f490a40..7cffad8 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -31,7 +31,7 @@
 
 #include "devices.h"
 
-static int pcm970_pins[] = {
+static const int pcm970_pins[] __initconst = {
 	/* SDHC */
 	PB4_PF_SD2_D0,
 	PB5_PF_SD2_D1,
-- 
1.7.2.3
