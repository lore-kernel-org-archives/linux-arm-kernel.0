From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Wed, 21 Nov 2018 12:08:06 +0100
Subject: [PATCH v4 4/4] ARM: OMAP1: ams-delta: Drop obsolete NAND resources
In-Reply-To: <20181121110806.32076-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
Message-ID: <20181121110806.32076-5-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amstrad Delta NAND driver now uses GPIO API for data I/O so there is no
need to assign memory I/O resource to the device any longer.  Drop it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 30c0d18f372e..d594f60c3224 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -296,20 +296,9 @@ struct modem_private_data {
 
 static struct modem_private_data modem_priv;
 
-static struct resource ams_delta_nand_resources[] = {
-	[0] = {
-		.start	= OMAP1_MPUIO_BASE,
-		.end	= OMAP1_MPUIO_BASE +
-				OMAP_MPUIO_IO_CNTL + sizeof(u32) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
 static struct platform_device ams_delta_nand_device = {
 	.name	= "ams-delta-nand",
 	.id	= -1,
-	.num_resources	= ARRAY_SIZE(ams_delta_nand_resources),
-	.resource	= ams_delta_nand_resources,
 };
 
 #define OMAP_GPIO_LABEL		"gpio-0-15"
-- 
2.18.1
