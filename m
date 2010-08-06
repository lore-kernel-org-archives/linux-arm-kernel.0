From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  6 Aug 2010 16:02:18 +0200
Subject: [PATCH 2/2] ARM i.MX51: Add Nand device support
In-Reply-To: <1281103338-19423-1-git-send-email-s.hauer@pengutronix.de>
References: <1281103338-19423-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281103338-19423-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/devices.c |   25 +++++++++++++++++++++++++
 arch/arm/mach-mx5/devices.h |    1 +
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 1920ff4..a3449ee 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -245,6 +245,31 @@ struct platform_device mxc_keypad_device = {
 	.resource = mxc_kpp_resources,
 };
 
+static struct resource mxc_nand_resources[] = {
+	{
+		/* NFC AXI register space */
+		.start	= MX51_NFC_AXI_BASE_ADDR,
+		.end	= MX51_NFC_AXI_BASE_ADDR + 0x3fff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		/* NFC IP register space */
+		.start	= MX51_NFC_BASE_ADDR,
+		.end	= MX51_NFC_BASE_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= MX51_MXC_INT_NFC,
+		.end	= MX51_MXC_INT_NFC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mxc_nand_device = {
+	.name = "mxc_nand",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(mxc_nand_resources),
+	.resource = mxc_nand_resources,
+};
+
 static struct mxc_gpio_port mxc_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index e509cfa..ceb1bcc 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -10,3 +10,4 @@ extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_hsi2c_device;
 extern struct platform_device mxc_keypad_device;
+extern struct platform_device mxc_nand_device;
-- 
1.7.1
