From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 14 Jul 2015 14:45:26 -0500
Subject: [PATCH 3/4] ARM: davinci: Set proper SPI prescale limit value
In-Reply-To: <1436903127-6777-1-git-send-email-fcooper@ti.com>
References: <1436903127-6777-1-git-send-email-fcooper@ti.com>
Message-ID: <1436903127-6777-4-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI Davinci driver has been updated to allow SOCs to specify their minimum
prescale value. Update the various SOCs board files that use this driver with
their proper prescaler limit.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 2 ++
 arch/arm/mach-davinci/dm355.c         | 1 +
 arch/arm/mach-davinci/dm365.c         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index ddfdd82..29e08aa 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1010,11 +1010,13 @@ static struct davinci_spi_platform_data da8xx_spi_pdata[] = {
 		.version	= SPI_VERSION_2,
 		.intr_line	= 1,
 		.dma_event_q	= EVENTQ_0,
+		.prescaler_limit = 2,
 	},
 	[1] = {
 		.version	= SPI_VERSION_2,
 		.intr_line	= 1,
 		.dma_event_q	= EVENTQ_0,
+		.prescaler_limit = 2,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9cbeda7..567dc56 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -411,6 +411,7 @@ static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.num_chipselect = 2,
 	.cshold_bug	= true,
 	.dma_event_q	= EVENTQ_1,
+	.prescaler_limit = 1,
 };
 static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index e3a3c54..6a890a8 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -646,6 +646,7 @@ static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.dma_event_q	= EVENTQ_3,
+	.prescaler_limit = 1,
 };
 
 static struct resource dm365_spi0_resources[] = {
-- 
1.9.1
