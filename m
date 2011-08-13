From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 14 Aug 2011 00:14:01 +0800
Subject: [PATCH v2 2/8] arm/mxc: do not use gpio_to_irq() for static
	initializers
In-Reply-To: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
References: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313252047-8820-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch defines IMX_GPIO_TO_IRQ() in mach/hardware.h and replaces
all the uses of gpio_to_irq() in static initializers with
IMX_GPIO_TO_IRQ().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-cpuimx35.c            |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-vpr200.c              |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c           |    8 ++++----
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    4 ++--
 arch/arm/mach-mx5/board-mx53_ard.c           |    4 ++--
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    2 +-
 arch/arm/mach-mx5/mx51_efika.c               |    2 +-
 arch/arm/plat-mxc/include/mach/hardware.h    |    2 ++
 9 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index f39a478b..13b7041 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -66,7 +66,7 @@ static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 		I2C_BOARD_INFO("tsc2007", 0x48),
 		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
-		.irq		= gpio_to_irq(TSC2007_IRQGPIO),
+		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
 	},
 };
 
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 6fa6934..097ff42 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -359,7 +359,7 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 		.bus_num	= 1,
 		.chip_select	= 0, /* SS0 */
 		.platform_data	= &mc13783_pdata,
-		.irq = gpio_to_irq(PMIC_INT),
+		.irq = IMX_GPIO_TO_IRQ(PMIC_INT),
 		.mode = SPI_CS_HIGH,
 	}, {
 		.modalias	= "l4f00242t03",
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 7d8e012..5250283 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -162,7 +162,7 @@ static struct i2c_board_info vpr200_i2c_devices[] = {
 	}, {
 		I2C_BOARD_INFO("mc13892", 0x08),
 		.platform_data = &vpr200_pmic,
-		.irq = gpio_to_irq(GPIO_PMIC_INT),
+		.irq = IMX_GPIO_TO_IRQ(GPIO_PMIC_INT),
 	}
 };
 
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 68934ea..49ec98e 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -57,7 +57,7 @@
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x400000),
-		.irq = gpio_to_irq(CPUIMX51_QUARTA_GPIO),
+		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTA_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -65,7 +65,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x800000),
-		.irq = gpio_to_irq(CPUIMX51_QUARTB_GPIO),
+		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTB_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -73,7 +73,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x1000000),
-		.irq = gpio_to_irq(CPUIMX51_QUARTC_GPIO),
+		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTC_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -81,7 +81,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
-		.irq = gpio_to_irq(CPUIMX51_QUARTD_GPIO),
+		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTD_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ff096d5..8badbdb 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -129,7 +129,7 @@ static struct i2c_board_info eukrea_cpuimx51sd_i2c_devices[] = {
 		I2C_BOARD_INFO("tsc2007", 0x49),
 		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
-		.irq		= gpio_to_irq(TSC2007_IRQGPIO),
+		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
 	},
 };
 
@@ -245,7 +245,7 @@ static struct spi_board_info cpuimx51sd_spi_device[] = {
 		.mode		= SPI_MODE_0,
 		.chip_select     = 0,
 		.platform_data   = &mcp251x_info,
-		.irq             = gpio_to_irq(CAN_IRQGPIO)
+		.irq             = IMX_GPIO_TO_IRQ(CAN_IRQGPIO)
 	},
 };
 
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..ddc3015 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -134,8 +134,8 @@ static struct resource ard_smsc911x_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start =  gpio_to_irq(ARD_ETHERNET_INT_B),
-		.end =  gpio_to_irq(ARD_ETHERNET_INT_B),
+		.start =  IMX_GPIO_TO_IRQ(ARD_ETHERNET_INT_B),
+		.end =  IMX_GPIO_TO_IRQ(ARD_ETHERNET_INT_B),
 		.flags = IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index bbf4564..ab0b1b2 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -160,7 +160,7 @@ struct tsc2007_platform_data tsc2007_data = {
 static struct i2c_board_info mbimx51_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("tsc2007", 0x49),
-		.irq  = gpio_to_irq(MBIMX51_TSC2007_GPIO),
+		.irq  = IMX_GPIO_TO_IRQ(MBIMX51_TSC2007_GPIO),
 		.platform_data = &tsc2007_data,
 	}, {
 		I2C_BOARD_INFO("tlv320aic23", 0x1a),
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index 4435e03..2a3015a 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -589,7 +589,7 @@ static struct spi_board_info mx51_efika_spi_board_info[] __initdata = {
 		.bus_num = 0,
 		.chip_select = 0,
 		.platform_data = &mx51_efika_mc13892_data,
-		.irq = gpio_to_irq(EFIKAMX_PMIC),
+		.irq = IMX_GPIO_TO_IRQ(EFIKAMX_PMIC),
 	},
 };
 
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index a8bfd56..77f6556 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -116,4 +116,6 @@
 	.type = _type,							\
 }
 
+#define IMX_GPIO_TO_IRQ(gpio)	(MXC_GPIO_IRQ_START + (gpio))
+
 #endif /* __ASM_ARCH_MXC_HARDWARE_H__ */
-- 
1.7.4.1
