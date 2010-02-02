From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:20 -0800
Subject: [PATCH 08/16] ARM: LPC32XX: Added LPC32XX identifier to GPIO register
	field macros
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-9-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The GPIO macros and associated code have been updated with the
LPC32XX identifier.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/gpiolib.c               |   96 +++++++++++++++----------
 arch/arm/mach-lpc32xx/include/mach/gpio.h     |   26 ++++----
 arch/arm/mach-lpc32xx/include/mach/platform.h |   78 ++++++++++----------
 arch/arm/mach-lpc32xx/phy3250.c               |    8 +-
 4 files changed, 114 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/gpiolib.c b/arch/arm/mach-lpc32xx/gpiolib.c
index 803c48f..beed7eb 100644
--- a/arch/arm/mach-lpc32xx/gpiolib.c
+++ b/arch/arm/mach-lpc32xx/gpiolib.c
@@ -42,12 +42,12 @@ struct gpio_regs {
 /*
  * GPIO names
  */
-static char *gpio_p0_names[GPIO_P0_MAX] = {
+static char *gpio_p0_names[LPC32XX_GPIO_P0_MAX] = {
 	"p0.0", "p0.1", "p0.2", "p0.3",
 	"p0.4", "p0.5", "p0.6", "p0.7"
 };
 
-static char *gpio_p1_names[GPIO_P1_MAX] = {
+static char *gpio_p1_names[LPC32XX_GPIO_P1_MAX] = {
 	"p1.0", "p1.1", "p1.2", "p1.3",
 	"p1.4", "p1.5", "p1.6", "p1.7",
 	"p1.8", "p1.9", "p1.10", "p1.11",
@@ -56,19 +56,19 @@ static char *gpio_p1_names[GPIO_P1_MAX] = {
 	"p1.20", "p1.21", "p1.22", "p1.23",
 };
 
-static char *gpio_p2_names[GPIO_P2_MAX] = {
+static char *gpio_p2_names[LPC32XX_GPIO_P2_MAX] = {
 	"p2.0", "p2.1", "p2.2", "p2.3",
 	"p2.4", "p2.5", "p2.6", "p2.7",
 	"p2.8", "p2.9", "p2.10", "p2.11",
 	"p2.12"
 };
 
-static char *gpio_p3_names[GPIO_P3_MAX] = {
+static char *gpio_p3_names[LPC32XX_GPIO_P3_MAX] = {
 	"gpi000", "gpio01", "gpio02", "gpio03",
 	"gpio04", "gpio05"
 };
 
-static char *gpi_p3_names[GPI_P3_MAX] = {
+static char *gpi_p3_names[LPC32XX_GPI_P3_MAX] = {
 	"gpi00", "gpi01", "gpi02", "gpi03",
 	"gpi04", "gpi05", "gpi06", "gpi07",
 	"gpi08", "gpi09", "na",    "na",
@@ -78,7 +78,7 @@ static char *gpi_p3_names[GPI_P3_MAX] = {
 	"gpi24", "gpi25", "gpi26", "gpi27"
 };
 
-static char *gpo_p3_names[GPO_P3_MAX] = {
+static char *gpo_p3_names[LPC32XX_GPO_P3_MAX] = {
 	"gpo00", "gpo01", "gpo02", "gpo03",
 	"gpo04", "gpo05", "gpo06", "gpo07",
 	"gpo08", "gpo09", "gpo10", "gpo11",
@@ -89,32 +89,52 @@ static char *gpo_p3_names[GPO_P3_MAX] = {
 
 static struct gpio_regs gpio_grp_regs[] = {
 	{
-		.inp_state	= (void __iomem *) GPIO_P0_INP_STATE(GPIOBASE),
-		.outp_set	= (void __iomem *) GPIO_P0_OUTP_SET(GPIOBASE),
-		.outp_clr	= (void __iomem *) GPIO_P0_OUTP_CLR(GPIOBASE),
-		.dir_set	= (void __iomem *) GPIO_P0_DIR_SET(GPIOBASE),
-		.dir_clr	= (void __iomem *) GPIO_P0_DIR_CLR(GPIOBASE),
+		.inp_state	=
+			(void __iomem *) LPC32XX_GPIO_P0_INP_STATE(GPIOBASE),
+		.outp_set	=
+			(void __iomem *) LPC32XX_GPIO_P0_OUTP_SET(GPIOBASE),
+		.outp_clr	=
+			(void __iomem *) LPC32XX_GPIO_P0_OUTP_CLR(GPIOBASE),
+		.dir_set	=
+			(void __iomem *) LPC32XX_GPIO_P0_DIR_SET(GPIOBASE),
+		.dir_clr	=
+			(void __iomem *) LPC32XX_GPIO_P0_DIR_CLR(GPIOBASE),
 	},
 	{
-		.inp_state	= (void __iomem *) GPIO_P1_INP_STATE(GPIOBASE),
-		.outp_set	= (void __iomem *) GPIO_P1_OUTP_SET(GPIOBASE),
-		.outp_clr	= (void __iomem *) GPIO_P1_OUTP_CLR(GPIOBASE),
-		.dir_set	= (void __iomem *) GPIO_P1_DIR_SET(GPIOBASE),
-		.dir_clr	= (void __iomem *) GPIO_P1_DIR_CLR(GPIOBASE),
+		.inp_state	=
+			(void __iomem *) LPC32XX_GPIO_P1_INP_STATE(GPIOBASE),
+		.outp_set	=
+			(void __iomem *) LPC32XX_GPIO_P1_OUTP_SET(GPIOBASE),
+		.outp_clr	=
+			(void __iomem *) LPC32XX_GPIO_P1_OUTP_CLR(GPIOBASE),
+		.dir_set	=
+			(void __iomem *) LPC32XX_GPIO_P1_DIR_SET(GPIOBASE),
+		.dir_clr	=
+			(void __iomem *) LPC32XX_GPIO_P1_DIR_CLR(GPIOBASE),
 	},
 	{
-		.inp_state	= (void __iomem *) GPIO_P2_INP_STATE(GPIOBASE),
-		.outp_set	= (void __iomem *) GPIO_P2_OUTP_SET(GPIOBASE),
-		.outp_clr	= (void __iomem *) GPIO_P2_OUTP_CLR(GPIOBASE),
-		.dir_set	= (void __iomem *) GPIO_P2_DIR_SET(GPIOBASE),
-		.dir_clr	= (void __iomem *) GPIO_P2_DIR_CLR(GPIOBASE),
+		.inp_state	=
+			(void __iomem *) LPC32XX_GPIO_P2_INP_STATE(GPIOBASE),
+		.outp_set	=
+			(void __iomem *) LPC32XX_GPIO_P2_OUTP_SET(GPIOBASE),
+		.outp_clr	=
+			(void __iomem *) LPC32XX_GPIO_P2_OUTP_CLR(GPIOBASE),
+		.dir_set	=
+			(void __iomem *) LPC32XX_GPIO_P2_DIR_SET(GPIOBASE),
+		.dir_clr	=
+			(void __iomem *) LPC32XX_GPIO_P2_DIR_CLR(GPIOBASE),
 	},
 	{
-		.inp_state	= (void __iomem *) GPIO_P3_INP_STATE(GPIOBASE),
-		.outp_set	= (void __iomem *) GPIO_P3_OUTP_SET(GPIOBASE),
-		.outp_clr	= (void __iomem *) GPIO_P3_OUTP_CLR(GPIOBASE),
-		.dir_set	= (void __iomem *) GPIO_P2_DIR_SET(GPIOBASE),
-		.dir_clr	= (void __iomem *) GPIO_P2_DIR_CLR(GPIOBASE),
+		.inp_state	=
+			(void __iomem *) LPC32XX_GPIO_P3_INP_STATE(GPIOBASE),
+		.outp_set	=
+			(void __iomem *) LPC32XX_GPIO_P3_OUTP_SET(GPIOBASE),
+		.outp_clr	=
+			(void __iomem *) LPC32XX_GPIO_P3_OUTP_CLR(GPIOBASE),
+		.dir_set	=
+			(void __iomem *) LPC32XX_GPIO_P2_DIR_SET(GPIOBASE),
+		.dir_clr	=
+			(void __iomem *) LPC32XX_GPIO_P2_DIR_CLR(GPIOBASE),
 	},
 };
 
@@ -329,8 +349,8 @@ static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
 			.direction_output	= lpc32xx_gpio_dir_output_p012,
 			.set			= lpc32xx_gpio_set_value_p012,
 			.request		= lpc32xx_gpio_request,
-			.base			= GPIO_P0_GRP,
-			.ngpio			= GPIO_P0_MAX,
+			.base			= LPC32XX_GPIO_P0_GRP,
+			.ngpio			= LPC32XX_GPIO_P0_MAX,
 			.names			= gpio_p0_names,
 			.can_sleep		= 0,
 		},
@@ -344,8 +364,8 @@ static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
 			.direction_output	= lpc32xx_gpio_dir_output_p012,
 			.set			= lpc32xx_gpio_set_value_p012,
 			.request		= lpc32xx_gpio_request,
-			.base			= GPIO_P1_GRP,
-			.ngpio			= GPIO_P1_MAX,
+			.base			= LPC32XX_GPIO_P1_GRP,
+			.ngpio			= LPC32XX_GPIO_P1_MAX,
 			.names			= gpio_p1_names,
 			.can_sleep		= 0,
 		},
@@ -359,8 +379,8 @@ static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
 			.direction_output	= lpc32xx_gpio_dir_output_p012,
 			.set			= lpc32xx_gpio_set_value_p012,
 			.request		= lpc32xx_gpio_request,
-			.base			= GPIO_P2_GRP,
-			.ngpio			= GPIO_P2_MAX,
+			.base			= LPC32XX_GPIO_P2_GRP,
+			.ngpio			= LPC32XX_GPIO_P2_MAX,
 			.names			= gpio_p2_names,
 			.can_sleep		= 0,
 		},
@@ -374,8 +394,8 @@ static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
 			.direction_output	= lpc32xx_gpio_dir_output_p3,
 			.set			= lpc32xx_gpio_set_value_p3,
 			.request		= lpc32xx_gpio_request,
-			.base			= GPIO_P3_GRP,
-			.ngpio			= GPIO_P3_MAX,
+			.base			= LPC32XX_GPIO_P3_GRP,
+			.ngpio			= LPC32XX_GPIO_P3_MAX,
 			.names			= gpio_p3_names,
 			.can_sleep		= 0,
 		},
@@ -387,8 +407,8 @@ static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
 			.direction_input	= lpc32xx_gpio_dir_in_always,
 			.get			= lpc32xx_gpi_get_value,
 			.request		= lpc32xx_gpio_request,
-			.base			= GPI_P3_GRP,
-			.ngpio			= GPI_P3_MAX,
+			.base			= LPC32XX_GPI_P3_GRP,
+			.ngpio			= LPC32XX_GPI_P3_MAX,
 			.names			= gpi_p3_names,
 			.can_sleep		= 0,
 		},
@@ -400,8 +420,8 @@ static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
 			.direction_output	= lpc32xx_gpio_dir_out_always,
 			.set			= lpc32xx_gpo_set_value,
 			.request		= lpc32xx_gpio_request,
-			.base			= GPO_P3_GRP,
-			.ngpio			= GPO_P3_MAX,
+			.base			= LPC32XX_GPO_P3_GRP,
+			.ngpio			= LPC32XX_GPO_P3_MAX,
 			.names			= gpo_p3_names,
 			.can_sleep		= 0,
 		},
diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
index 8df2198..e95b113 100644
--- a/arch/arm/mach-lpc32xx/include/mach/gpio.h
+++ b/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -34,23 +34,23 @@
  * GPIO pins: 8xP0 group, 24xP1 group, 13xP2 group, 6xP3 group
  */
 
-#define GPIO_P0_MAX 8
-#define GPIO_P1_MAX 24
-#define GPIO_P2_MAX 13
-#define GPIO_P3_MAX 6
-#define GPI_P3_MAX 28
-#define GPO_P3_MAX 24
+#define LPC32XX_GPIO_P0_MAX 8
+#define LPC32XX_GPIO_P1_MAX 24
+#define LPC32XX_GPIO_P2_MAX 13
+#define LPC32XX_GPIO_P3_MAX 6
+#define LPC32XX_GPI_P3_MAX 28
+#define LPC32XX_GPO_P3_MAX 24
 
-#define GPIO_P0_GRP 0
-#define GPIO_P1_GRP (GPIO_P0_GRP + GPIO_P0_MAX)
-#define GPIO_P2_GRP (GPIO_P1_GRP + GPIO_P1_MAX)
-#define GPIO_P3_GRP (GPIO_P2_GRP + GPIO_P2_MAX)
-#define GPI_P3_GRP (GPIO_P3_GRP + GPIO_P3_MAX)
-#define GPO_P3_GRP (GPI_P3_GRP + GPI_P3_MAX)
+#define LPC32XX_GPIO_P0_GRP 0
+#define LPC32XX_GPIO_P1_GRP (LPC32XX_GPIO_P0_GRP + LPC32XX_GPIO_P0_MAX)
+#define LPC32XX_GPIO_P2_GRP (LPC32XX_GPIO_P1_GRP + LPC32XX_GPIO_P1_MAX)
+#define LPC32XX_GPIO_P3_GRP (LPC32XX_GPIO_P2_GRP + LPC32XX_GPIO_P2_MAX)
+#define LPC32XX_GPI_P3_GRP (LPC32XX_GPIO_P3_GRP + LPC32XX_GPIO_P3_MAX)
+#define LPC32XX_GPO_P3_GRP (LPC32XX_GPI_P3_GRP + LPC32XX_GPI_P3_MAX)
 
 /*
  * A specific GPIO can be selected with this macro
- * ie, GPIO_05 can be selected with LPC32XX_GPIO(GPIO_P3_GRP, 5)
+ * ie, GPIO_05 can be selected with LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 5)
  * See the LPC32x0 User's guide for GPIO group numbers
  */
 #define LPC32XX_GPIO(x, y) ((x) + (y))
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index 9de37ee..adc932b 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -690,44 +690,44 @@
  * GPIO Module Register offsets
  *
  */
-#define GPIO_P3_INP_STATE(x)		((x) + 0x000)
-#define GPIO_P3_OUTP_SET(x)		((x) + 0x004)
-#define GPIO_P3_OUTP_CLR(x)		((x) + 0x008)
-#define GPIO_P3_OUTP_STATE(x)		((x) + 0x00C)
-#define GPIO_P2_DIR_SET(x)		((x) + 0x010)
-#define GPIO_P2_DIR_CLR(x)		((x) + 0x014)
-#define GPIO_P2_DIR_STATE(x)		((x) + 0x018)
-#define GPIO_P2_INP_STATE(x)		((x) + 0x01C)
-#define GPIO_P2_OUTP_SET(x)		((x) + 0x020)
-#define GPIO_P2_OUTP_CLR(x)		((x) + 0x024)
-#define GPIO_P2_MUX_SET(x)		((x) + 0x028)
-#define GPIO_P2_MUX_CLR(x)		((x) + 0x02C)
-#define GPIO_P2_MUX_STATE(x)		((x) + 0x030)
-#define GPIO_P0_INP_STATE(x)		((x) + 0x040)
-#define GPIO_P0_OUTP_SET(x)		((x) + 0x044)
-#define GPIO_P0_OUTP_CLR(x)		((x) + 0x048)
-#define GPIO_P0_OUTP_STATE(x)		((x) + 0x04C)
-#define GPIO_P0_DIR_SET(x)		((x) + 0x050)
-#define GPIO_P0_DIR_CLR(x)		((x) + 0x054)
-#define GPIO_P0_DIR_STATE(x)		((x) + 0x058)
-#define GPIO_P1_INP_STATE(x)		((x) + 0x060)
-#define GPIO_P1_OUTP_SET(x)		((x) + 0x064)
-#define GPIO_P1_OUTP_CLR(x)		((x) + 0x068)
-#define GPIO_P1_OUTP_STATE(x)		((x) + 0x06C)
-#define GPIO_P1_DIR_SET(x)		((x) + 0x070)
-#define GPIO_P1_DIR_CLR(x)		((x) + 0x074)
-#define GPIO_P1_DIR_STATE(x)		((x) + 0x078)
-#define GPIO_P_MUX_SET(x)		((x) + 0x100)
-#define GPIO_P_MUX_CLR(x)		((x) + 0x104)
-#define GPIO_P_MUX_STATE(x)		((x) + 0x108)
-#define GPIO_P3_MUX_SET(x)		((x) + 0x110)
-#define GPIO_P3_MUX_CLR(x)		((x) + 0x114)
-#define GPIO_P3_MUX_STATE(x)		((x) + 0x118)
-#define GPIO_P0_MUX_SET(x)		((x) + 0x120)
-#define GPIO_P0_MUX_CLR(x)		((x) + 0x124)
-#define GPIO_P0_MUX_STATE(x)		((x) + 0x128)
-#define GPIO_P1_MUX_SET(x)		((x) + 0x130)
-#define GPIO_P1_MUX_CLR(x)		((x) + 0x134)
-#define GPIO_P1_MUX_STATE(x)		((x) + 0x138)
+#define LPC32XX_GPIO_P3_INP_STATE(x)		((x) + 0x000)
+#define LPC32XX_GPIO_P3_OUTP_SET(x)		((x) + 0x004)
+#define LPC32XX_GPIO_P3_OUTP_CLR(x)		((x) + 0x008)
+#define LPC32XX_GPIO_P3_OUTP_STATE(x)		((x) + 0x00C)
+#define LPC32XX_GPIO_P2_DIR_SET(x)		((x) + 0x010)
+#define LPC32XX_GPIO_P2_DIR_CLR(x)		((x) + 0x014)
+#define LPC32XX_GPIO_P2_DIR_STATE(x)		((x) + 0x018)
+#define LPC32XX_GPIO_P2_INP_STATE(x)		((x) + 0x01C)
+#define LPC32XX_GPIO_P2_OUTP_SET(x)		((x) + 0x020)
+#define LPC32XX_GPIO_P2_OUTP_CLR(x)		((x) + 0x024)
+#define LPC32XX_GPIO_P2_MUX_SET(x)		((x) + 0x028)
+#define LPC32XX_GPIO_P2_MUX_CLR(x)		((x) + 0x02C)
+#define LPC32XX_GPIO_P2_MUX_STATE(x)		((x) + 0x030)
+#define LPC32XX_GPIO_P0_INP_STATE(x)		((x) + 0x040)
+#define LPC32XX_GPIO_P0_OUTP_SET(x)		((x) + 0x044)
+#define LPC32XX_GPIO_P0_OUTP_CLR(x)		((x) + 0x048)
+#define LPC32XX_GPIO_P0_OUTP_STATE(x)		((x) + 0x04C)
+#define LPC32XX_GPIO_P0_DIR_SET(x)		((x) + 0x050)
+#define LPC32XX_GPIO_P0_DIR_CLR(x)		((x) + 0x054)
+#define LPC32XX_GPIO_P0_DIR_STATE(x)		((x) + 0x058)
+#define LPC32XX_GPIO_P1_INP_STATE(x)		((x) + 0x060)
+#define LPC32XX_GPIO_P1_OUTP_SET(x)		((x) + 0x064)
+#define LPC32XX_GPIO_P1_OUTP_CLR(x)		((x) + 0x068)
+#define LPC32XX_GPIO_P1_OUTP_STATE(x)		((x) + 0x06C)
+#define LPC32XX_GPIO_P1_DIR_SET(x)		((x) + 0x070)
+#define LPC32XX_GPIO_P1_DIR_CLR(x)		((x) + 0x074)
+#define LPC32XX_GPIO_P1_DIR_STATE(x)		((x) + 0x078)
+#define LPC32XX_GPIO_P_MUX_SET(x)		((x) + 0x100)
+#define LPC32XX_GPIO_P_MUX_CLR(x)		((x) + 0x104)
+#define LPC32XX_GPIO_P_MUX_STATE(x)		((x) + 0x108)
+#define LPC32XX_GPIO_P3_MUX_SET(x)		((x) + 0x110)
+#define LPC32XX_GPIO_P3_MUX_CLR(x)		((x) + 0x114)
+#define LPC32XX_GPIO_P3_MUX_STATE(x)		((x) + 0x118)
+#define LPC32XX_GPIO_P0_MUX_SET(x)		((x) + 0x120)
+#define LPC32XX_GPIO_P0_MUX_CLR(x)		((x) + 0x124)
+#define LPC32XX_GPIO_P0_MUX_STATE(x)		((x) + 0x128)
+#define LPC32XX_GPIO_P1_MUX_SET(x)		((x) + 0x130)
+#define LPC32XX_GPIO_P1_MUX_CLR(x)		((x) + 0x134)
+#define LPC32XX_GPIO_P1_MUX_STATE(x)		((x) + 0x138)
 
 #endif
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 0612994..80958b9 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -48,10 +48,10 @@
 /*
  * Mapped GPIOLIB GPIOs
  */
-#define SPI0_CS_GPIO	LPC32XX_GPIO(GPIO_P3_GRP, 5)
-#define LCD_POWER_GPIO	LPC32XX_GPIO(GPO_P3_GRP, 0)
-#define BKL_POWER_GPIO	LPC32XX_GPIO(GPO_P3_GRP, 4)
-#define LED_GPIO	LPC32XX_GPIO(GPO_P3_GRP, 1)
+#define SPI0_CS_GPIO	LPC32XX_GPIO(LPC32XX_GPIO_P3_GRP, 5)
+#define LCD_POWER_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 0)
+#define BKL_POWER_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 4)
+#define LED_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 1)
 
 /*
  * AMBA LCD controller
-- 
1.6.6
