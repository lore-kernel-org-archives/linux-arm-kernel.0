From: jaccon.bastiaansen@gmail.com (Jaccon Bastiaansen)
Date: Tue, 27 Sep 2011 20:31:09 +0200
Subject: [PATCH V2] Add CS890x0 ethernet controller support to the i.MX21ADS
Message-ID: <1317148269-14996-1-git-send-email-jaccon.bastiaansen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
---
 arch/arm/mach-imx/mach-mx21ads.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 74ac889..62b4717 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -159,6 +159,26 @@ static struct platform_device mx21ads_nor_mtd_device = {
 	.resource = &mx21ads_flash_resource,
 };
 
+static struct resource mx21ads_cs8900_resources[] = {
+	{
+		.start	= (u32)MX21ADS_CS8900A_IOBASE_REG,
+		.end	= (u32)MX21ADS_CS8900A_IOBASE_REG + 0x200000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= MX21ADS_CS8900A_IRQ,
+		.end	= MX21ADS_CS8900A_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mx21ads_cs8900_device = {
+	.name		= "cs89x0",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mx21ads_cs8900_resources),
+	.resource	= mx21ads_cs8900_resources,
+};
+
 static const struct imxuart_platform_data uart_pdata_rts __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -275,6 +295,7 @@ static void __init mx21ads_map_io(void)
 
 static struct platform_device *platform_devices[] __initdata = {
 	&mx21ads_nor_mtd_device,
+	&mx21ads_cs8900_device
 };
 
 static void __init mx21ads_board_init(void)
-- 
1.7.1
