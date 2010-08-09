From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 9 Aug 2010 19:18:14 +0530
Subject: [PATCH 1/4] ux500: add DB8500 SD/MMC platform devices
Message-ID: <1281361697-4874-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanumath Prasad <hanumath.prasad@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/devices-db8500.c       |   76 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/devices.h |    7 +++
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 9280d25..f2e01a6 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -110,6 +110,82 @@ struct platform_device u8500_i2c4_device = {
 	.num_resources	= ARRAY_SIZE(u8500_i2c4_resources),
 };
 
+/*
+ * SD/MMC
+ */
+
+struct amba_device u8500_sdi0_device = {
+	.dev		= {
+		.init_name = "sdi0",
+	},
+	.res		= {
+		.start	= U8500_SDI0_BASE,
+		.end	= U8500_SDI0_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= {IRQ_DB8500_SDMMC0, NO_IRQ},
+};
+
+struct amba_device u8500_sdi1_device = {
+	.dev		= {
+		.init_name = "sdi1",
+	},
+	.res		= {
+		.start	= U8500_SDI1_BASE,
+		.end	= U8500_SDI1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= {IRQ_DB8500_SDMMC1, NO_IRQ},
+};
+
+struct amba_device u8500_sdi2_device = {
+	.dev		= {
+		.init_name = "sdi2",
+	},
+	.res		= {
+		.start	= U8500_SDI2_BASE,
+		.end	= U8500_SDI2_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= {IRQ_DB8500_SDMMC2, NO_IRQ},
+};
+
+struct amba_device u8500_sdi3_device = {
+	.dev		= {
+		.init_name = "sdi3",
+	},
+	.res		= {
+		.start	= U8500_SDI3_BASE,
+		.end	= U8500_SDI3_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= {IRQ_DB8500_SDMMC3, NO_IRQ},
+};
+
+struct amba_device u8500_sdi4_device = {
+	.dev		= {
+		.init_name = "sdi4",
+	},
+	.res		= {
+		.start	= U8500_SDI4_BASE,
+		.end	= U8500_SDI4_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= {IRQ_DB8500_SDMMC4, NO_IRQ},
+};
+
+struct amba_device u8500_sdi5_device = {
+	.dev		= {
+		.init_name = "sdi5",
+	},
+	.res		= {
+		.start	= U8500_SDI5_BASE,
+		.end	= U8500_SDI5_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq		= {IRQ_DB8500_SDMMC5, NO_IRQ},
+};
+
 static struct resource dma40_resources[] = {
 	[0] = {
 		.start = U8500_DMA_BASE,
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index c2b2f25..33a120c 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -27,6 +27,13 @@ extern struct platform_device u8500_i2c0_device;
 extern struct platform_device u8500_i2c4_device;
 extern struct platform_device u8500_dma40_device;
 
+extern struct amba_device u8500_sdi0_device;
+extern struct amba_device u8500_sdi1_device;
+extern struct amba_device u8500_sdi2_device;
+extern struct amba_device u8500_sdi3_device;
+extern struct amba_device u8500_sdi4_device;
+extern struct amba_device u8500_sdi5_device;
+
 void dma40_u8500ed_fixup(void);
 
 #endif
-- 
1.7.2.dirty
