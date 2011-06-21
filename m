From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 21 Jun 2011 14:49:35 -0300
Subject: [PATCH 1/3] ARM: imx2: Fix GPIO iosize
Message-ID: <1308678577-25277-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MX1, MX21 and MX27 each GPIO port has an address space of 256 bytes.

Fix the iosize for these platforms.

Tested on a mx27_3ds board that can boot fine after this change.

Cc: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This applies on Sascha's for-next branch

 arch/arm/mach-imx/mm-imx1.c  |   12 ++++++++----
 arch/arm/mach-imx/mm-imx21.c |   12 ++++++------
 arch/arm/mach-imx/mm-imx27.c |   12 ++++++------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index b486595..8a953fd 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -50,8 +50,12 @@ void __init mx1_init_irq(void)
 
 void __init imx1_soc_init(void)
 {
-	mxc_register_gpio(0, MX1_GPIO1_BASE_ADDR, SZ_4K, MX1_GPIO_INT_PORTA, 0);
-	mxc_register_gpio(1, MX1_GPIO2_BASE_ADDR, SZ_4K, MX1_GPIO_INT_PORTB, 0);
-	mxc_register_gpio(2, MX1_GPIO3_BASE_ADDR, SZ_4K, MX1_GPIO_INT_PORTC, 0);
-	mxc_register_gpio(3, MX1_GPIO4_BASE_ADDR, SZ_4K, MX1_GPIO_INT_PORTD, 0);
+	mxc_register_gpio(0, MX1_GPIO1_BASE_ADDR, SZ_256,
+						MX1_GPIO_INT_PORTA, 0);
+	mxc_register_gpio(1, MX1_GPIO2_BASE_ADDR, SZ_256,
+						MX1_GPIO_INT_PORTB, 0);
+	mxc_register_gpio(2, MX1_GPIO3_BASE_ADDR, SZ_256,
+						MX1_GPIO_INT_PORTC, 0);
+	mxc_register_gpio(3, MX1_GPIO4_BASE_ADDR, SZ_256,
+						MX1_GPIO_INT_PORTD, 0);
 }
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index f0fb8bc..f8fb41c 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -76,10 +76,10 @@ void __init mx21_init_irq(void)
 
 void __init imx21_soc_init(void)
 {
-	mxc_register_gpio(0, MX21_GPIO1_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
-	mxc_register_gpio(1, MX21_GPIO2_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
-	mxc_register_gpio(2, MX21_GPIO3_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
-	mxc_register_gpio(3, MX21_GPIO4_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
-	mxc_register_gpio(4, MX21_GPIO5_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
-	mxc_register_gpio(5, MX21_GPIO6_BASE_ADDR, SZ_4K, MX21_INT_GPIO, 0);
+	mxc_register_gpio(0, MX21_GPIO1_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio(1, MX21_GPIO2_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio(2, MX21_GPIO3_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio(3, MX21_GPIO4_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio(4, MX21_GPIO5_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
+	mxc_register_gpio(5, MX21_GPIO6_BASE_ADDR, SZ_256, MX21_INT_GPIO, 0);
 }
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index d3700ce..acc6db4 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -76,10 +76,10 @@ void __init mx27_init_irq(void)
 
 void __init imx27_soc_init(void)
 {
-	mxc_register_gpio(0, MX27_GPIO1_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
-	mxc_register_gpio(1, MX27_GPIO2_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
-	mxc_register_gpio(2, MX27_GPIO3_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
-	mxc_register_gpio(3, MX27_GPIO4_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
-	mxc_register_gpio(4, MX27_GPIO5_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
-	mxc_register_gpio(5, MX27_GPIO6_BASE_ADDR, SZ_4K, MX27_INT_GPIO, 0);
+	mxc_register_gpio(0, MX27_GPIO1_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio(1, MX27_GPIO2_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio(2, MX27_GPIO3_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio(3, MX27_GPIO4_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio(4, MX27_GPIO5_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
+	mxc_register_gpio(5, MX27_GPIO6_BASE_ADDR, SZ_256, MX27_INT_GPIO, 0);
 }
-- 
1.6.0.4
