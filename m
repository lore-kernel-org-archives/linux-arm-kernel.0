From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 19 Sep 2011 14:51:26 +0200
Subject: [PATCH 02/11] at91/boards: use -1 for invalid gpio
In-Reply-To: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1316436695-19194-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will allow to use gpio_is_valid

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-1arm.c         |    1 +
 arch/arm/mach-at91/board-afeb-9260v1.c  |    7 ++++++-
 arch/arm/mach-at91/board-cam60.c        |    3 ++-
 arch/arm/mach-at91/board-cap9adk.c      |   14 ++++++++------
 arch/arm/mach-at91/board-carmeva.c      |    6 ++++--
 arch/arm/mach-at91/board-cpu9krea.c     |    7 ++++++-
 arch/arm/mach-at91/board-cpuat91.c      |    4 ++++
 arch/arm/mach-at91/board-csb337.c       |    4 +++-
 arch/arm/mach-at91/board-csb637.c       |    1 +
 arch/arm/mach-at91/board-eb9200.c       |    8 ++++++--
 arch/arm/mach-at91/board-ecbat91.c      |    4 ++++
 arch/arm/mach-at91/board-eco920.c       |    4 ++++
 arch/arm/mach-at91/board-flexibity.c    |    4 +++-
 arch/arm/mach-at91/board-foxg20.c       |    6 +++++-
 arch/arm/mach-at91/board-gsia18s.c      |    4 +++-
 arch/arm/mach-at91/board-kafa.c         |    1 +
 arch/arm/mach-at91/board-kb9202.c       |    5 ++++-
 arch/arm/mach-at91/board-neocore926.c   |    4 +++-
 arch/arm/mach-at91/board-pcontrol-g20.c |    1 +
 arch/arm/mach-at91/board-picotux200.c   |    2 ++
 arch/arm/mach-at91/board-qil-a9260.c    |   11 ++++++-----
 arch/arm/mach-at91/board-rm9200dk.c     |   10 +++++++---
 arch/arm/mach-at91/board-rm9200ek.c     |    2 ++
 arch/arm/mach-at91/board-sam9-l9260.c   |    7 ++++---
 arch/arm/mach-at91/board-sam9260ek.c    |   11 ++++++-----
 arch/arm/mach-at91/board-sam9261ek.c    |    8 ++++++--
 arch/arm/mach-at91/board-sam9263ek.c    |    7 ++++---
 arch/arm/mach-at91/board-sam9g20ek.c    |    8 +++++++-
 arch/arm/mach-at91/board-sam9m10g45ek.c |    3 +++
 arch/arm/mach-at91/board-sam9rlek.c     |    7 ++++---
 arch/arm/mach-at91/board-snapper9260.c  |    5 +++++
 arch/arm/mach-at91/board-stamp9g20.c    |   11 +++++++++--
 arch/arm/mach-at91/board-usb-a926x.c    |    5 +++--
 arch/arm/mach-at91/board-yl-9200.c      |    6 ++++--
 34 files changed, 141 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 5aa5885..17d9163 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -70,6 +70,7 @@ static struct at91_eth_data __initdata onearm_eth_data = {
 
 static struct at91_usbh_data __initdata onearm_usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata onearm_udc_data = {
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index b0c796d..c489c27 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -75,6 +75,7 @@ static void __init afeb9260_init_early(void)
  */
 static struct at91_usbh_data __initdata afeb9260_usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -82,7 +83,7 @@ static struct at91_usbh_data __initdata afeb9260_usbh_data = {
  */
 static struct at91_udc_data __initdata afeb9260_udc_data = {
 	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
@@ -143,6 +144,7 @@ static struct atmel_nand_data __initdata afeb9260_nand_data = {
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
 	.bus_width_16	= 0,
+	.det_pin	= -1,
 };
 
 
@@ -154,6 +156,7 @@ static struct at91_mmc_data __initdata afeb9260_mmc_data = {
 	.wp_pin 	= AT91_PIN_PC4,
 	.slot_b		= 1,
 	.wire4		= 1,
+	.vcc_pin	= -1,
 };
 
 
@@ -174,6 +177,8 @@ static struct i2c_board_info __initdata afeb9260_i2c_devices[] = {
 static struct at91_cf_data afeb9260_cf_data = {
 	.chipselect = 4,
 	.irq_pin    = AT91_PIN_PA6,
+	.det_pin	= -1,
+	.vcc_pin	= -1,
 	.rst_pin    = AT91_PIN_PA7,
 	.flags      = AT91_CF_TRUE_IDE,
 };
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index d1abd58..ed3d87d 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -62,6 +62,7 @@ static void __init cam60_init_early(void)
  */
 static struct at91_usbh_data __initdata cam60_usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 
@@ -141,7 +142,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata cam60_nand_data = {
 	.ale		= 21,
 	.cle		= 22,
-	// .det_pin	= ... not there
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PA9,
 	.enable_pin	= AT91_PIN_PA7,
 	.partition_info	= nand_partitions,
diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
index 679b0b7..da392f3 100644
--- a/arch/arm/mach-at91/board-cap9adk.c
+++ b/arch/arm/mach-at91/board-cap9adk.c
@@ -70,6 +70,7 @@ static void __init cap9adk_init_early(void)
  */
 static struct at91_usbh_data __initdata cap9adk_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -144,9 +145,9 @@ static struct spi_board_info cap9adk_spi_devices[] = {
  */
 static struct at91_mmc_data __initdata cap9adk_mmc_data = {
 	.wire4		= 1,
-//	.det_pin	= ... not connected
-//	.wp_pin		= ... not connected
-//	.vcc_pin	= ... not connected
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 
@@ -154,6 +155,7 @@ static struct at91_mmc_data __initdata cap9adk_mmc_data = {
  * MACB Ethernet device
  */
 static struct at91_eth_data __initdata cap9adk_macb_data = {
+	.phy_irq_pin	= -1,
 	.is_rmii	= 1,
 };
 
@@ -178,8 +180,8 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata cap9adk_nand_data = {
 	.ale		= 21,
 	.cle		= 22,
-//	.det_pin	= ... not connected
-//	.rdy_pin	= ... not connected
+	.det_pin	= -1,
+	.rdy_pin	= -1,
 	.enable_pin	= AT91_PIN_PD15,
 	.partition_info	= nand_partitions,
 };
@@ -356,7 +358,7 @@ static struct atmel_lcdfb_info __initdata cap9adk_lcdc_data;
  * AC97
  */
 static struct ac97c_platform_data cap9adk_ac97_data = {
-//	.reset_pin	= ... not connected
+	.reset_pin	= -1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index c578c5d..40be90a 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -64,6 +64,7 @@ static struct at91_eth_data __initdata carmeva_eth_data = {
 
 static struct at91_usbh_data __initdata carmeva_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata carmeva_udc_data = {
@@ -75,8 +76,8 @@ static struct at91_udc_data __initdata carmeva_udc_data = {
 // static struct at91_cf_data __initdata carmeva_cf_data = {
 //	.det_pin	= AT91_PIN_PB0,
 //	.rst_pin	= AT91_PIN_PC5,
-	// .irq_pin	= ... not connected
-	// .vcc_pin	= ... always powered
+	// .irq_pin	= -1,
+	// .vcc_pin	= -1,
 // };
 
 static struct at91_mmc_data __initdata carmeva_mmc_data = {
@@ -84,6 +85,7 @@ static struct at91_mmc_data __initdata carmeva_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PB10,
 	.wp_pin		= AT91_PIN_PC14,
+	.vcc_pin	= -1,
 };
 
 static struct spi_board_info carmeva_spi_devices[] = {
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index f4da8a1..a8cdccc 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -86,6 +86,7 @@ static void __init cpu9krea_init_early(void)
  */
 static struct at91_usbh_data __initdata cpu9krea_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -93,13 +94,14 @@ static struct at91_usbh_data __initdata cpu9krea_usbh_data = {
  */
 static struct at91_udc_data __initdata cpu9krea_udc_data = {
 	.vbus_pin	= AT91_PIN_PC8,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 /*
  * MACB Ethernet device
  */
 static struct at91_eth_data __initdata cpu9krea_macb_data = {
+	.phy_irq_pin	= -1,
 	.is_rmii	= 1,
 };
 
@@ -112,6 +114,7 @@ static struct atmel_nand_data __initdata cpu9krea_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.bus_width_16	= 0,
+	.det_pin	= -1,
 };
 
 #ifdef CONFIG_MACH_CPU9260
@@ -337,6 +340,8 @@ static struct at91_mmc_data __initdata cpu9krea_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PA29,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 static void __init cpu9krea_board_init(void)
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 2d919f5..02af1cf 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -83,11 +83,13 @@ static void __init cpuat91_init_early(void)
 }
 
 static struct at91_eth_data __initdata cpuat91_eth_data = {
+	.phy_irq_pin	= -1,
 	.is_rmii	= 1,
 };
 
 static struct at91_usbh_data __initdata cpuat91_usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata cpuat91_udc_data = {
@@ -98,6 +100,8 @@ static struct at91_udc_data __initdata cpuat91_udc_data = {
 static struct at91_mmc_data __initdata cpuat91_mmc_data = {
 	.det_pin	= AT91_PIN_PC2,
 	.wire4		= 1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 static struct physmap_flash_data cpuat91_flash_data = {
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 17654d5..c16f0f7 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -65,11 +65,12 @@ static struct at91_eth_data __initdata csb337_eth_data = {
 
 static struct at91_usbh_data __initdata csb337_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata csb337_udc_data = {
-	// this has no VBUS sensing pin
 	.pullup_pin	= AT91_PIN_PA24,
+	.vbus_pin	= -1,
 };
 
 static struct i2c_board_info __initdata csb337_i2c_devices[] = {
@@ -98,6 +99,7 @@ static struct at91_mmc_data __initdata csb337_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
 	.wp_pin		= AT91_PIN_PD6,
+	.vcc_pin	= -1,
 };
 
 static struct spi_board_info csb337_spi_devices[] = {
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index 72b5567..0e2d219 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -59,6 +59,7 @@ static struct at91_eth_data __initdata csb637_eth_data = {
 
 static struct at91_usbh_data __initdata csb637_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata csb637_udc_data = {
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index 01170a2..b920f46 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -67,6 +67,7 @@ static struct at91_eth_data __initdata eb9200_eth_data = {
 
 static struct at91_usbh_data __initdata eb9200_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata eb9200_udc_data = {
@@ -75,15 +76,18 @@ static struct at91_udc_data __initdata eb9200_udc_data = {
 };
 
 static struct at91_cf_data __initdata eb9200_cf_data = {
+	.irq_pin	= -1,
 	.det_pin	= AT91_PIN_PB0,
+	.vcc_pin	= -1,
 	.rst_pin	= AT91_PIN_PC5,
-	// .irq_pin	= ... not connected
-	// .vcc_pin	= ... always powered
 };
 
 static struct at91_mmc_data __initdata eb9200_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 static struct i2c_board_info __initdata eb9200_i2c_devices[] = {
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 7c0313c..b2ae86c 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -71,11 +71,15 @@ static struct at91_eth_data __initdata ecb_at91eth_data = {
 
 static struct at91_usbh_data __initdata ecb_at91usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_mmc_data __initdata ecb_at91mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index 8252c72..ca1a7d0 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -54,6 +54,7 @@ static struct at91_eth_data __initdata eco920_eth_data = {
 
 static struct at91_usbh_data __initdata eco920_usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata eco920_udc_data = {
@@ -64,6 +65,9 @@ static struct at91_udc_data __initdata eco920_udc_data = {
 static struct at91_mmc_data __initdata eco920_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 0,
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 static struct physmap_flash_data eco920_flash_data = {
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 4c3f65d..8605d49 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -52,12 +52,13 @@ static void __init flexibity_init_early(void)
 /* USB Host port */
 static struct at91_usbh_data __initdata flexibity_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /* USB Device port */
 static struct at91_udc_data __initdata flexibity_udc_data = {
 	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 /* SPI devices */
@@ -76,6 +77,7 @@ static struct at91_mmc_data __initdata flexibity_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PC9,
 	.wp_pin		= AT91_PIN_PC4,
+	.vcc_pin	= -1,
 };
 
 /* LEDs */
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index f27d1a7..7a2e505 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -106,6 +106,7 @@ static void __init foxg20_init_early(void)
  */
 static struct at91_usbh_data __initdata foxg20_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -113,7 +114,7 @@ static struct at91_usbh_data __initdata foxg20_usbh_data = {
  */
 static struct at91_udc_data __initdata foxg20_udc_data = {
 	.vbus_pin	= AT91_PIN_PC6,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
@@ -147,6 +148,9 @@ static struct at91_eth_data __initdata foxg20_macb_data = {
 static struct at91_mmc_data __initdata foxg20_mmc_data = {
 	.slot_b		= 1,
 	.wire4		= 1,
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 2e95949..1c36ea2 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -80,6 +80,7 @@ static void __init gsia18s_init_early(void)
  */
 static struct at91_usbh_data __initdata usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -87,7 +88,7 @@ static struct at91_usbh_data __initdata usbh_data = {
  */
 static struct at91_udc_data __initdata udc_data = {
 	.vbus_pin	= AT91_PIN_PA22,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 /*
@@ -530,6 +531,7 @@ static struct i2c_board_info __initdata gsia18s_i2c_devices[] = {
 static struct at91_cf_data __initdata gsia18s_cf1_data = {
 	.irq_pin	= AT91_PIN_PA27,
 	.det_pin	= AT91_PIN_PB30,
+	.vcc_pin	= -1,
 	.rst_pin	= AT91_PIN_PB31,
 	.chipselect	= 5,
 	.flags		= AT91_CF_TRUE_IDE,
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index 4a17089..8d64e90 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -68,6 +68,7 @@ static struct at91_eth_data __initdata kafa_eth_data = {
 
 static struct at91_usbh_data __initdata kafa_usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata kafa_udc_data = {
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 9dc8d49..be5ed23 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -76,6 +76,7 @@ static struct at91_eth_data __initdata kb9202_eth_data = {
 
 static struct at91_usbh_data __initdata kb9202_usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata kb9202_udc_data = {
@@ -87,6 +88,8 @@ static struct at91_mmc_data __initdata kb9202_mmc_data = {
 	.det_pin	= AT91_PIN_PB2,
 	.slot_b		= 0,
 	.wire4		= 1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 static struct mtd_partition __initdata kb9202_nand_partition[] = {
@@ -106,7 +109,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata kb9202_nand_data = {
 	.ale		= 22,
 	.cle		= 21,
-	// .det_pin	= ... not there
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PC29,
 	.enable_pin	= AT91_PIN_PC28,
 	.partition_info	= nand_partitions,
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 9bc6ab3..2f6cc36 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -79,7 +79,7 @@ static struct at91_usbh_data __initdata neocore926_usbh_data = {
  */
 static struct at91_udc_data __initdata neocore926_udc_data = {
 	.vbus_pin	= AT91_PIN_PA25,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
@@ -149,6 +149,7 @@ static struct at91_mmc_data __initdata neocore926_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PE18,
 	.wp_pin		= AT91_PIN_PE19,
+	.vcc_pin	= -1,
 };
 
 
@@ -195,6 +196,7 @@ static struct atmel_nand_data __initdata neocore926_nand_data = {
 	.rdy_pin_active_low	= 1,
 	.enable_pin		= AT91_PIN_PD15,
 	.partition_info		= nand_partitions,
+	.det_pin		= -1,
 };
 
 static struct sam9_smc_config __initdata neocore926_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 49e3f69..f817cb8 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -107,6 +107,7 @@ static void __init add_device_pcontrol(void)
  */
 static struct at91_usbh_data __initdata usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index b7b8390..88b2a84 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -67,6 +67,7 @@ static struct at91_eth_data __initdata picotux200_eth_data = {
 
 static struct at91_usbh_data __initdata picotux200_usbh_data = {
 	.ports		= 1,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_mmc_data __initdata picotux200_mmc_data = {
@@ -74,6 +75,7 @@ static struct at91_mmc_data __initdata picotux200_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
 	.wp_pin		= AT91_PIN_PA17,
+	.vcc_pin	= -1,
 };
 
 #define PICOTUX200_FLASH_BASE	AT91_CHIPSELECT_0
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index 81f9110..1cdde5c 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -77,6 +77,7 @@ static void __init ek_init_early(void)
  */
 static struct at91_usbh_data __initdata ek_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -84,7 +85,7 @@ static struct at91_usbh_data __initdata ek_usbh_data = {
  */
 static struct at91_udc_data __initdata ek_udc_data = {
 	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 /*
@@ -139,7 +140,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata ek_nand_data = {
 	.ale		= 21,
 	.cle		= 22,
-//	.det_pin	= ... not connected
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
@@ -177,9 +178,9 @@ static void __init ek_add_device_nand(void)
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
-//	.det_pin	= ... not connected
-//	.wp_pin		= ... not connected
-//	.vcc_pin	= ... not connected
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 /*
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 6f08faa..5198d87 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -72,6 +72,7 @@ static struct at91_eth_data __initdata dk_eth_data = {
 
 static struct at91_usbh_data __initdata dk_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata dk_udc_data = {
@@ -80,16 +81,19 @@ static struct at91_udc_data __initdata dk_udc_data = {
 };
 
 static struct at91_cf_data __initdata dk_cf_data = {
+	.irq_pin	= -1,
 	.det_pin	= AT91_PIN_PB0,
+	.vcc_pin	= -1,
 	.rst_pin	= AT91_PIN_PC5,
-	// .irq_pin	= ... not connected
-	// .vcc_pin	= ... always powered
 };
 
 #ifndef CONFIG_MTD_AT91_DATAFLASH_CARD
 static struct at91_mmc_data __initdata dk_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 #endif
 
@@ -149,7 +153,7 @@ static struct atmel_nand_data __initdata dk_nand_data = {
 	.cle		= 21,
 	.det_pin	= AT91_PIN_PB1,
 	.rdy_pin	= AT91_PIN_PC2,
-	// .enable_pin	= ... not there
+	.enable_pin	= -1,
 	.partition_info	= nand_partitions,
 };
 
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 85bcccd..4fb14c0 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -72,6 +72,7 @@ static struct at91_eth_data __initdata ek_eth_data = {
 
 static struct at91_usbh_data __initdata ek_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata ek_udc_data = {
@@ -85,6 +86,7 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
 	.wp_pin		= AT91_PIN_PA17,
+	.vcc_pin	= -1,
 };
 #endif
 
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index 4d3a02f..6069d0f 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -72,6 +72,7 @@ static void __init ek_init_early(void)
  */
 static struct at91_usbh_data __initdata ek_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -79,7 +80,7 @@ static struct at91_usbh_data __initdata ek_usbh_data = {
  */
 static struct at91_udc_data __initdata ek_udc_data = {
 	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
@@ -140,7 +141,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata ek_nand_data = {
 	.ale		= 21,
 	.cle		= 22,
-//	.det_pin	= ... not connected
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
@@ -181,7 +182,7 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PC8,
 	.wp_pin		= AT91_PIN_PC4,
-//	.vcc_pin	= ... not connected
+	.vcc_pin	= -1,
 };
 
 static void __init ek_board_init(void)
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index 8a50c3e..9681120 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -75,6 +75,7 @@ static void __init ek_init_early(void)
  */
 static struct at91_usbh_data __initdata ek_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -82,7 +83,7 @@ static struct at91_usbh_data __initdata ek_usbh_data = {
  */
 static struct at91_udc_data __initdata ek_udc_data = {
 	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
@@ -182,7 +183,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata ek_nand_data = {
 	.ale		= 21,
 	.cle		= 22,
-//	.det_pin	= ... not connected
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
@@ -228,9 +229,9 @@ static void __init ek_add_device_nand(void)
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.slot_b		= 1,
 	.wire4		= 1,
-//	.det_pin	= ... not connected
-//	.wp_pin		= ... not connected
-//	.vcc_pin	= ... not connected
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 5096a0e..8ce4753 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -151,6 +151,7 @@ static void __init ek_add_device_dm9000(void) {}
  */
 static struct at91_usbh_data __initdata ek_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 
@@ -159,7 +160,7 @@ static struct at91_usbh_data __initdata ek_usbh_data = {
  */
 static struct at91_udc_data __initdata ek_udc_data = {
 	.vbus_pin	= AT91_PIN_PB29,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
@@ -188,7 +189,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata ek_nand_data = {
 	.ale		= 22,
 	.cle		= 21,
-//	.det_pin	= ... not connected
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PC15,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
@@ -350,6 +351,9 @@ static struct spi_board_info ek_spi_devices[] = {
  */
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wire4		= 1,
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 #endif /* CONFIG_SPI_ATMEL_* */
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index ea8f185..4855a9a 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -81,7 +81,7 @@ static struct at91_usbh_data __initdata ek_usbh_data = {
  */
 static struct at91_udc_data __initdata ek_udc_data = {
 	.vbus_pin	= AT91_PIN_PA25,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
@@ -151,7 +151,7 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PE18,
 	.wp_pin		= AT91_PIN_PE19,
-//	.vcc_pin	= ... not connected
+	.vcc_pin	= -1,
 };
 
 
@@ -189,7 +189,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata ek_nand_data = {
 	.ale		= 21,
 	.cle		= 22,
-//	.det_pin	= ... not connected
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PA22,
 	.enable_pin	= AT91_PIN_PD15,
 	.partition_info	= nand_partitions,
@@ -358,6 +358,7 @@ static void __init ek_add_device_buttons(void) {}
  * reset_pin is not connected: NRST
  */
 static struct ac97c_platform_data ek_ac97_data = {
+	.reset_pin	= -1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 817f59d..90fb231 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -86,6 +86,7 @@ static void __init ek_init_early(void)
  */
 static struct at91_usbh_data __initdata ek_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -93,7 +94,7 @@ static struct at91_usbh_data __initdata ek_usbh_data = {
  */
 static struct at91_udc_data __initdata ek_udc_data = {
 	.vbus_pin	= AT91_PIN_PC5,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
@@ -170,6 +171,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
+	.det_pin	= -1,
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
@@ -215,6 +217,7 @@ static struct mci_platform_data __initdata ek_mmc_data = {
 	.slot[1] = {
 		.bus_width	= 4,
 		.detect_pin	= AT91_PIN_PC9,
+		.wp_pin		= -1;
 	},
 
 };
@@ -223,6 +226,8 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.slot_b		= 1,	/* Only one slot so use slot B */
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PC9,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 #endif
 
@@ -232,6 +237,7 @@ static void __init ek_add_device_mmc(void)
 	if (ek_have_2mmc()) {
 		ek_mmc_data.slot[0].bus_width = 4;
 		ek_mmc_data.slot[0].detect_pin = AT91_PIN_PC2;
+		ek_mmc_data.slot[0].wp_pin = -1;
 	}
 	at91_add_device_mci(0, &ek_mmc_data);
 #else
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index ad234cc..a5dad78 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -100,6 +100,7 @@ static struct mci_platform_data __initdata mci0_data = {
 	.slot[0] = {
 		.bus_width	= 4,
 		.detect_pin	= AT91_PIN_PD10,
+		.wp_pin		= -1;
 	},
 };
 
@@ -150,6 +151,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.rdy_pin	= AT91_PIN_PC8,
 	.enable_pin	= AT91_PIN_PC14,
 	.partition_info	= nand_partitions,
+	.det_pin	= -1,
 };
 
 static struct sam9_smc_config __initdata ek_nand_smc_config = {
@@ -335,6 +337,7 @@ static void __init ek_add_device_buttons(void) {}
  * reset_pin is not connected: NRST
  */
 static struct ac97c_platform_data ek_ac97_data = {
+	.reset_pin	= -1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index 4f14b54..903505a 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -67,8 +67,8 @@ static struct usba_platform_data __initdata ek_usba_udc_data = {
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PA15,
-//	.wp_pin		= ... not connected
-//	.vcc_pin	= ... not connected
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 
@@ -97,7 +97,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata ek_nand_data = {
 	.ale		= 21,
 	.cle		= 22,
-//	.det_pin	= ... not connected
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PD17,
 	.enable_pin	= AT91_PIN_PB6,
 	.partition_info	= nand_partitions,
@@ -209,6 +209,7 @@ static struct atmel_lcdfb_info __initdata ek_lcdc_data;
  * reset_pin is not connected: NRST
  */
 static struct ac97c_platform_data ek_ac97_data = {
+	.reset_pin	= -1,
 };
 
 
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index c73d25e..837591b 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -57,15 +57,18 @@ static void __init snapper9260_init_early(void)
 
 static struct at91_usbh_data __initdata snapper9260_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 static struct at91_udc_data __initdata snapper9260_udc_data = {
 	.vbus_pin		= SNAPPER9260_IO_EXP_GPIO(5),
 	.vbus_active_low	= 1,
 	.vbus_polled		= 1,
+	.pullup_pin		= -1,
 };
 
 static struct at91_eth_data snapper9260_macb_data = {
+	.phy_irq_pin	= -1,
 	.is_rmii	= 1,
 };
 
@@ -110,6 +113,8 @@ static struct atmel_nand_data __initdata snapper9260_nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.partition_info	= snapper9260_nand_partition_info,
 	.bus_width_16	= 0,
+	.enable_pin	= -1,
+	.det_pin	= -1,
 };
 
 static struct sam9_smc_config __initdata snapper9260_nand_smc_config = {
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 936e5fd..6162976 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -85,6 +85,7 @@ static struct atmel_nand_data __initdata nand_data = {
 	.rdy_pin	= AT91_PIN_PC13,
 	.enable_pin	= AT91_PIN_PC14,
 	.bus_width_16	= 0,
+	.det_pin	= -1,
 };
 
 static struct sam9_smc_config __initdata nand_smc_config = {
@@ -122,12 +123,17 @@ static void __init add_device_nand(void)
 static struct mci_platform_data __initdata mmc_data = {
 	.slot[0] = {
 		.bus_width	= 4,
+		.detect_pin	= -1;
+		.wp_pin		= -1;
 	},
 };
 #else
 static struct at91_mmc_data __initdata mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
+	.det_pin	= -1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 #endif
 
@@ -137,6 +143,7 @@ static struct at91_mmc_data __initdata mmc_data = {
  */
 static struct at91_usbh_data __initdata usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 
@@ -145,12 +152,12 @@ static struct at91_usbh_data __initdata usbh_data = {
  */
 static struct at91_udc_data __initdata portuxg20_udc_data = {
 	.vbus_pin	= AT91_PIN_PC7,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 static struct at91_udc_data __initdata stamp9g20evb_udc_data = {
 	.vbus_pin	= AT91_PIN_PA22,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index 260260b..ffa5aab 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -66,6 +66,7 @@ static void __init ek_init_early(void)
  */
 static struct at91_usbh_data __initdata ek_usbh_data = {
 	.ports		= 2,
+	.vbus_pin	= {-1, -1},
 };
 
 /*
@@ -73,7 +74,7 @@ static struct at91_usbh_data __initdata ek_usbh_data = {
  */
 static struct at91_udc_data __initdata ek_udc_data = {
 	.vbus_pin	= AT91_PIN_PB11,
-	.pullup_pin	= 0,		/* pull-up driven by UDC */
+	.pullup_pin	= -1,		/* pull-up driven by UDC */
 };
 
 static void __init ek_add_device_udc(void)
@@ -199,7 +200,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata ek_nand_data = {
 	.ale		= 21,
 	.cle		= 22,
-//	.det_pin	= ... not connected
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PA22,
 	.enable_pin	= AT91_PIN_PD15,
 	.partition_info	= nand_partitions,
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 95edcbd..5108bd7 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -120,6 +120,7 @@ static struct at91_eth_data __initdata yl9200_eth_data = {
  */
 static struct at91_usbh_data __initdata yl9200_usbh_data = {
 	.ports			= 1,	/* PQFP version of AT91RM9200 */
+	.vbus_pin		= {-1, -1},
 };
 
 /*
@@ -137,8 +138,9 @@ static struct at91_udc_data __initdata yl9200_udc_data = {
  */
 static struct at91_mmc_data __initdata yl9200_mmc_data = {
 	.det_pin	= AT91_PIN_PB9,
-	// .wp_pin	= ... not connected
 	.wire4		= 1,
+	.wp_pin		= -1,
+	.vcc_pin	= -1,
 };
 
 /*
@@ -181,7 +183,7 @@ static struct mtd_partition * __init nand_partitions(int size, int *num_partitio
 static struct atmel_nand_data __initdata yl9200_nand_data = {
 	.ale		= 6,
 	.cle		= 7,
-	// .det_pin	= ... not connected
+	.det_pin	= -1,
 	.rdy_pin	= AT91_PIN_PC14,	/* R/!B (Sheet10) */
 	.enable_pin	= AT91_PIN_PC15,	/* !CE  (Sheet10) */
 	.partition_info	= nand_partitions,
-- 
1.7.5.4
