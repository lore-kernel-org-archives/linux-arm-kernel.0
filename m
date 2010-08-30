From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:33 +0530
Subject: [PATCH 70/74] SPEAr13XX: Update register/macros/devices/routine names
	and pmx dev registration to implement single image for multiple
	boards.
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <a901d8d1f766afb770b14cbfb2985eb026ecb6ba.1283161024.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/clock.c                  |   12 +++---
 arch/arm/mach-spear13xx/include/mach/generic.h   |   47 ++++++++++-----------
 arch/arm/mach-spear13xx/include/mach/irqs.h      |    1 -
 arch/arm/mach-spear13xx/include/mach/spear1310.h |    6 +-
 arch/arm/mach-spear13xx/spear1300.c              |    9 +++-
 arch/arm/mach-spear13xx/spear1300_evb.c          |   47 +++++++++-----------
 arch/arm/mach-spear13xx/spear1310.c              |   13 ++++--
 arch/arm/mach-spear13xx/spear1310_evb.c          |   49 ++++++++++------------
 arch/arm/mach-spear13xx/spear13xx.c              |   34 ++++++++--------
 9 files changed, 108 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index cad2bbb..044319b 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -988,15 +988,15 @@ static struct pclk_info phy_pclk_info[] = {
 static struct pclk_sel phy_pclk_sel = {
 	.pclk_info = phy_pclk_info,
 	.pclk_count = ARRAY_SIZE(phy_pclk_info),
-	.pclk_sel_reg = (unsigned int *)(IO_ADDRESS(RAS_CTRL_REG1)),
-	.pclk_sel_mask = PHY_CLK_MASK,
+	.pclk_sel_reg = (unsigned int *)(IO_ADDRESS(SPEAR1310_RAS_CTRL_REG1)),
+	.pclk_sel_mask = SPEAR1310_PHY_CLK_MASK,
 };
 
 /* Phy 1 Clock */
 struct clk gmac_phy1_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk_sel = &phy_pclk_sel,
-	.pclk_sel_shift = PHY_CLK_SHIFT,
+	.pclk_sel_shift = SPEAR1310_PHY_CLK_SHIFT,
 	.recalc = &follow_parent,
 };
 
@@ -1004,7 +1004,7 @@ struct clk gmac_phy1_clk = {
 static struct clk gmac_phy2_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk_sel = &phy_pclk_sel,
-	.pclk_sel_shift = PHY_CLK_SHIFT,
+	.pclk_sel_shift = SPEAR1310_PHY_CLK_SHIFT,
 	.recalc = &follow_parent,
 };
 
@@ -1012,7 +1012,7 @@ static struct clk gmac_phy2_clk = {
 static struct clk gmac_phy3_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk_sel = &phy_pclk_sel,
-	.pclk_sel_shift = PHY_CLK_SHIFT,
+	.pclk_sel_shift = SPEAR1310_PHY_CLK_SHIFT,
 	.recalc = &follow_parent,
 };
 
@@ -1020,7 +1020,7 @@ static struct clk gmac_phy3_clk = {
 static struct clk gmac_phy4_clk = {
 	.flags = ALWAYS_ENABLED,
 	.pclk_sel = &phy_pclk_sel,
-	.pclk_sel_shift = PHY_CLK_SHIFT,
+	.pclk_sel_shift = SPEAR1310_PHY_CLK_SHIFT,
 	.recalc = &follow_parent,
 };
 
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index d453b60..75e9b82 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -35,7 +35,6 @@
 
 #if defined(CONFIG_MACH_SPEAR1310)
 #define SPEAR1310_FUNC_CNTL_0	UL(0x6C800000)
-
 #define PMX_SMII_MASK		(1 << 24)	/* Func cntl reg0 */
 #endif
 
@@ -217,26 +216,24 @@ extern struct pmx_dev pmx_uart1_modem;
 #define SPEAR_GPT0_CHAN0_IRQ	IRQ_GPT0_TMR0
 #define SPEAR_GPT0_CHAN1_IRQ	IRQ_GPT0_TMR1
 
-extern struct pmx_driver pmx_driver;
-
 /* Add spear13xx family device structure declarations here */
-extern struct amba_device gpio_device[];
-extern struct amba_device ssp_device;
-extern struct amba_device uart_device;
-extern struct platform_device ehci0_device;
-extern struct platform_device ehci1_device;
-extern struct platform_device i2c_device;
-extern struct platform_device kbd_device;
-extern struct platform_device nand_device;
-extern struct platform_device fsmc_nor_device;
-extern struct platform_device ohci0_device;
-extern struct platform_device ohci1_device;
-extern struct platform_device rtc_device;
-extern struct platform_device sdhci_device;
-extern struct platform_device smi_device;
-extern struct platform_device pcie_gadget0_device;
-extern struct platform_device pcie_gadget1_device;
-extern struct platform_device pcie_gadget2_device;
+extern struct amba_device spear13xx_gpio_device[];
+extern struct amba_device spear13xx_ssp_device;
+extern struct amba_device spear13xx_uart_device;
+extern struct platform_device spear13xx_ehci0_device;
+extern struct platform_device spear13xx_ehci1_device;
+extern struct platform_device spear13xx_i2c_device;
+extern struct platform_device spear13xx_kbd_device;
+extern struct platform_device spear13xx_nand_device;
+extern struct platform_device spear13xx_fsmc_nor_device;
+extern struct platform_device spear13xx_ohci0_device;
+extern struct platform_device spear13xx_ohci1_device;
+extern struct platform_device spear13xx_rtc_device;
+extern struct platform_device spear13xx_sdhci_device;
+extern struct platform_device spear13xx_smi_device;
+extern struct platform_device spear13xx_pcie_gadget0_device;
+extern struct platform_device spear13xx_pcie_gadget1_device;
+extern struct platform_device spear13xx_pcie_gadget2_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear13xx family function declarations here */
@@ -252,18 +249,20 @@ void spear13xx_secondary_startup(void);
 /* spear1300 declarations */
 #ifdef CONFIG_MACH_SPEAR1300
 /* Add spear1300 machine function declarations here */
-void __init spear1300_init(void);
+void __init spear1300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR1300 */
 
 /* spear1310 declarations */
 #ifdef CONFIG_MACH_SPEAR1310
 /* Add spear1310 machine device structure declarations here */
-extern struct platform_device can0_device;
-extern struct platform_device can1_device;
+extern struct platform_device spear1310_can0_device;
+extern struct platform_device spear1310_can1_device;
 
 /* Add spear1310 machine function declarations here */
-void __init spear1310_init(void);
+void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR1310 */
 
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index 1ca70a6..19ebdf0 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -122,7 +122,6 @@
 #endif /* CONFIG_MACH_SPEAR1310 */
 
 #define IRQ_GIC_END		(IRQ_SHPI_START + 128)
-
 #define VIRQ_START		IRQ_GIC_END
 
 /* GPIO pins virtual irqs */
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1310.h b/arch/arm/mach-spear13xx/include/mach/spear1310.h
index fd97c64..5fa69bb 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear1310.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear1310.h
@@ -21,9 +21,9 @@
 #define SPEAR1310_RAS_BASE		UL(0x6C800000)
 
 /* RAS Area Control Register */
-#define RAS_CTRL_REG1		(SPEAR1310_RAS_BASE + 0x4)
-#define PHY_CLK_MASK		0xF
-#define PHY_CLK_SHIFT		0
+#define SPEAR1310_RAS_CTRL_REG1		(SPEAR1310_RAS_BASE + 0x4)
+#define SPEAR1310_PHY_CLK_MASK		0xF
+#define SPEAR1310_PHY_CLK_SHIFT		0
 
 #endif /* __MACH_SPEAR1310_H */
 
diff --git a/arch/arm/mach-spear13xx/spear1300.c b/arch/arm/mach-spear13xx/spear1300.c
index 28822a3..b10f7a0 100644
--- a/arch/arm/mach-spear13xx/spear1300.c
+++ b/arch/arm/mach-spear13xx/spear1300.c
@@ -15,11 +15,12 @@
 #include <mach/spear.h>
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver;
+static struct pmx_driver pmx_driver;
 
 /* Add spear1300 specific devices here */
 
-void __init spear1300_init(void)
+void __init spear1300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
 	int ret;
 
@@ -27,6 +28,10 @@ void __init spear1300_init(void)
 	spear13xx_init();
 
 	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
 	ret = pmx_register(&pmx_driver);
 	if (ret)
 		pr_err("padmux: registeration failed. err no: %d\n", ret);
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index e297981..9d7229f 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -58,24 +58,24 @@ static struct pmx_dev *pmx_devs[] = {
 };
 
 static struct amba_device *amba_devs[] __initdata = {
-	&gpio_device[0],
-	&gpio_device[1],
-	&ssp_device,
-	&uart_device,
+	&spear13xx_gpio_device[0],
+	&spear13xx_gpio_device[1],
+	&spear13xx_ssp_device,
+	&spear13xx_uart_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
-	&ehci0_device,
-	&ehci1_device,
-	&i2c_device,
-	&kbd_device,
-	&nand_device,
-	&ohci0_device,
-	&ohci1_device,
-	&rtc_device,
-	&sdhci_device,
-	&smi_device,
-	&pcie_gadget0_device,
+	&spear13xx_ehci0_device,
+	&spear13xx_ehci1_device,
+	&spear13xx_i2c_device,
+	&spear13xx_kbd_device,
+	&spear13xx_nand_device,
+	&spear13xx_ohci0_device,
+	&spear13xx_ohci1_device,
+	&spear13xx_rtc_device,
+	&spear13xx_sdhci_device,
+	&spear13xx_smi_device,
+	&spear13xx_pcie_gadget0_device,
 };
 
 /* keyboard specific platform data */
@@ -153,11 +153,6 @@ static int spear1300_pcie_port_is_host(int port)
 
 static void __init spear1300_evb_init(void)
 {
-	/* padmux initialization, must be done before spear1300_init */
-	pmx_driver.mode = NULL;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-
 #ifdef CONFIG_CACHE_L2X0
 	/*
 	 * 256KB (16KB/way), 16-way associativity, parity not
@@ -170,21 +165,21 @@ static void __init spear1300_evb_init(void)
 #endif
 
 	/* set keyboard plat data */
-	kbd_set_plat_data(&kbd_device, &kbd_data);
+	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
 
 	/* set nand device's plat data */
-	nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+	nand_set_plat_data(&spear13xx_nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
 			SPEAR_NAND_BW8);
 	nand_mach_init(SPEAR_NAND_BW8);
 
 	/* call spear1300 machine init function */
-	spear1300_init();
+	spear1300_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Register slave devices on the I2C buses */
 	i2c_register_board_devices();
 
 	/* initialize serial nor related data in smi plat data */
-	smi_init_board_info(&smi_device);
+	smi_init_board_info(&spear13xx_smi_device);
 
 #ifdef CONFIG_PCIEPORTBUS
 	/* Enable PCIE0 clk */
@@ -192,7 +187,7 @@ static void __init spear1300_evb_init(void)
 	pcie_init(&spear1300_pcie_port_is_host);
 #endif
 	/* initialize fsmc related data in fsmc plat data */
-	fsmc_init_board_info(&fsmc_nor_device, partition_info,
+	fsmc_init_board_info(&spear13xx_fsmc_nor_device, partition_info,
 			ARRAY_SIZE(partition_info), FSMC_FLASH_WIDTH8);
 
 	/* Add Platform Devices */
@@ -202,7 +197,7 @@ static void __init spear1300_evb_init(void)
 	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
 	/* Initialize fsmc regiters */
-	fsmc_nor_init(&fsmc_nor_device, SPEAR13XX_FSMC_BASE, 0,
+	fsmc_nor_init(&spear13xx_fsmc_nor_device, SPEAR13XX_FSMC_BASE, 0,
 			FSMC_FLASH_WIDTH8);
 
 	spi_init();
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 3b38a4c..5cadea8 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -17,7 +17,7 @@
 #include <mach/hardware.h>
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver;
+static struct pmx_driver pmx_driver;
 
 /* Pad multiplexing for uart1_modem device */
 static struct pmx_mux_reg pmx_uart1_modem_mux[] = {
@@ -338,7 +338,7 @@ static struct resource can0_resources[] = {
 	},
 };
 
-struct platform_device can0_device = {
+struct platform_device spear1310_can0_device = {
 	.name = "spear_can",
 	.id = 0,
 	.num_resources = ARRAY_SIZE(can0_resources),
@@ -356,14 +356,15 @@ static struct resource can1_resources[] = {
 	},
 };
 
-struct platform_device can1_device = {
+struct platform_device spear1310_can1_device = {
 	.name = "spear_can",
 	.id = 1,
 	.num_resources = ARRAY_SIZE(can1_resources),
 	.resource = can1_resources,
 };
 
-void __init spear1310_init(void)
+void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
 	int ret;
 
@@ -371,6 +372,10 @@ void __init spear1310_init(void)
 	spear13xx_init();
 
 	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
 	ret = pmx_register(&pmx_driver);
 	if (ret)
 		pr_err("padmux: registeration failed. err no: %d\n", ret);
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index dec9ceb..6335b88 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -62,28 +62,28 @@ static struct pmx_dev *pmx_devs[] = {
 
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear13xx specific devices */
-	&gpio_device[0],
-	&gpio_device[1],
-	&uart_device,
+	&spear13xx_gpio_device[0],
+	&spear13xx_gpio_device[1],
+	&spear13xx_uart_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear13xx specific devices */
-	&ehci0_device,
-	&ehci1_device,
-	&i2c_device,
-	&kbd_device,
-	&nand_device,
-	&ohci0_device,
-	&ohci1_device,
-	&rtc_device,
-	&sdhci_device,
-	&smi_device,
-	&pcie_gadget0_device,
+	&spear13xx_ehci0_device,
+	&spear13xx_ehci1_device,
+	&spear13xx_i2c_device,
+	&spear13xx_kbd_device,
+	&spear13xx_nand_device,
+	&spear13xx_ohci0_device,
+	&spear13xx_ohci1_device,
+	&spear13xx_rtc_device,
+	&spear13xx_sdhci_device,
+	&spear13xx_smi_device,
+	&spear13xx_pcie_gadget0_device,
 
 	/* spear1310 specific devices */
-	&can0_device,
-	&can1_device,
+	&spear1310_can0_device,
+	&spear1310_can1_device,
 };
 
 /* keyboard specific platform data */
@@ -160,29 +160,24 @@ int spear1310_pcie_port_is_host(int port)
 
 static void __init spear1310_evb_init(void)
 {
-	/* padmux initialization, must be done before spear1300_init */
-	pmx_driver.mode = NULL;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-
 	/* set keyboard plat data */
-	kbd_set_plat_data(&kbd_device, &kbd_data);
+	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
 
 	/* set nand device's plat data */
-	nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
+	nand_set_plat_data(&spear13xx_nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
 			SPEAR_NAND_BW8);
 	nand_mach_init(SPEAR_NAND_BW8);
 
 	/* call spear1310 machine init function */
-	spear1310_init();
+	spear1310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Register slave devices on the I2C buses */
 	i2c_register_board_devices();
 
 	/* initialize serial nor related data in smi plat data */
-	smi_init_board_info(&smi_device);
+	smi_init_board_info(&spear13xx_smi_device);
 	/* initialize fsmc related data in fsmc plat data */
-	fsmc_init_board_info(&fsmc_nor_device, partition_info,
+	fsmc_init_board_info(&spear13xx_fsmc_nor_device, partition_info,
 			ARRAY_SIZE(partition_info), FSMC_FLASH_WIDTH8);
 
 #ifdef CONFIG_PCIEPORTBUS
@@ -198,7 +193,7 @@ static void __init spear1310_evb_init(void)
 	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
 	/* Initialize fsmc regiters */
-	fsmc_nor_init(&fsmc_nor_device, SPEAR13XX_FSMC_BASE, 0,
+	fsmc_nor_init(&spear13xx_fsmc_nor_device, SPEAR13XX_FSMC_BASE, 0,
 			FSMC_FLASH_WIDTH8);
 
 	spi_init();
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index c02073f..d183e5a 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -40,7 +40,7 @@ static struct pl061_platform_data gpio_plat_data[] = {
 	},
 };
 
-struct amba_device gpio_device[] = {
+struct amba_device spear13xx_gpio_device[] = {
 	{
 		.dev = {
 			.init_name = "gpio0",
@@ -82,7 +82,7 @@ static struct pl022_ssp_controller ssp_platform_data = {
 	.num_chipselect = 2,
 };
 
-struct amba_device ssp_device = {
+struct amba_device spear13xx_ssp_device = {
 	.dev = {
 		.coherent_dma_mask = ~0,
 		.init_name = "ssp-pl022",
@@ -97,7 +97,7 @@ struct amba_device ssp_device = {
 };
 
 /* uart device registeration */
-struct amba_device uart_device = {
+struct amba_device spear13xx_uart_device = {
 	.dev = {
 		.init_name = "uart",
 	},
@@ -121,7 +121,7 @@ static struct resource i2c_resources[] = {
 	},
 };
 
-struct platform_device i2c_device = {
+struct platform_device spear13xx_i2c_device = {
 	.name = "i2c_designware",
 	.id = 0,
 	.dev = {
@@ -142,7 +142,7 @@ static struct resource fsmc_nor_resources[] = {
 	},
 };
 
-struct platform_device fsmc_nor_device = {
+struct platform_device spear13xx_fsmc_nor_device = {
 	.name	= "physmap-flash",
 	.id	= -1,
 	.resource = fsmc_nor_resources,
@@ -198,7 +198,7 @@ static struct resource nand_resources[] = {
 	},
 };
 
-struct platform_device nand_device = {
+struct platform_device spear13xx_nand_device = {
 	.name = "nand",
 	.id = -1,
 	.resource = nand_resources,
@@ -259,7 +259,7 @@ static int usbh0_id;
 static int usbh1_id = 1;
 static u64 ehci0_dmamask = ~0;
 
-struct platform_device ehci0_device = {
+struct platform_device spear13xx_ehci0_device = {
 	.name = "spear-ehci",
 	.id = 0,
 	.dev = {
@@ -273,7 +273,7 @@ struct platform_device ehci0_device = {
 
 static u64 ehci1_dmamask = ~0;
 
-struct platform_device ehci1_device = {
+struct platform_device spear13xx_ehci1_device = {
 	.name = "spear-ehci",
 	.id = 1,
 	.dev = {
@@ -287,7 +287,7 @@ struct platform_device ehci1_device = {
 
 static u64 ohci0_dmamask = ~0;
 
-struct platform_device ohci0_device = {
+struct platform_device spear13xx_ohci0_device = {
 	.name = "spear-ohci",
 	.id = 0,
 	.dev = {
@@ -300,7 +300,7 @@ struct platform_device ohci0_device = {
 };
 
 static u64 ohci1_dmamask = ~0;
-struct platform_device ohci1_device = {
+struct platform_device spear13xx_ohci1_device = {
 	.name = "spear-ohci",
 	.id = 1,
 	.dev = {
@@ -324,7 +324,7 @@ static struct resource kbd_resources[] = {
 	},
 };
 
-struct platform_device kbd_device = {
+struct platform_device spear13xx_kbd_device = {
 	.name = "keyboard",
 	.id = -1,
 	.num_resources = ARRAY_SIZE(kbd_resources),
@@ -343,7 +343,7 @@ static struct resource rtc_resources[] = {
 	},
 };
 
-struct platform_device rtc_device = {
+struct platform_device spear13xx_rtc_device = {
 	.name = "rtc-spear",
 	.id = -1,
 	.num_resources = ARRAY_SIZE(rtc_resources),
@@ -362,7 +362,7 @@ static struct resource smi_resources[] = {
 	},
 };
 
-struct platform_device smi_device = {
+struct platform_device spear13xx_smi_device = {
 	.name = "smi",
 	.id = -1,
 	.num_resources = ARRAY_SIZE(smi_resources),
@@ -419,7 +419,7 @@ static struct resource sdhci_resources[] = {
 	}
 };
 
-struct platform_device sdhci_device = {
+struct platform_device spear13xx_sdhci_device = {
 	.dev = {
 		.coherent_dma_mask = ~0,
 	},
@@ -449,7 +449,7 @@ static struct resource pcie_gadget0_resources[] = {
 static int pcie_gadget0_id;
 static u64 pcie_gadget0_dmamask = ~0;
 
-struct platform_device pcie_gadget0_device = {
+struct platform_device spear13xx_pcie_gadget0_device = {
 	.name = "pcie-gadget-spear",
 	.id = 0,
 	.dev = {
@@ -480,7 +480,7 @@ static struct resource pcie_gadget1_resources[] = {
 static int pcie_gadget1_id;
 static u64 pcie_gadget1_dmamask = ~0;
 
-struct platform_device pcie_gadget1_device = {
+struct platform_device spear13xx_pcie_gadget1_device = {
 	.name = "pcie-gadget-spear",
 	.id = 1,
 	.dev = {
@@ -511,7 +511,7 @@ static struct resource pcie_gadget2_resources[] = {
 static int pcie_gadget2_id;
 static u64 pcie_gadget2_dmamask = ~0;
 
-struct platform_device pcie_gadget2_device = {
+struct platform_device spear13xx_pcie_gadget2_device = {
 	.name = "pcie-gadget-spear",
 	.id = 2,
 	.dev = {
-- 
1.7.2.2
