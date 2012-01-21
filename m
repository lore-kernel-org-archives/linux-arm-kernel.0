From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Jan 2012 13:36:37 +0900
Subject: [PATCH 6/7] ARM: S5PV210: use static declaration when it is not used
 in other files
Message-ID: <010e01ccd7f6$42f52330$c8df6990$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/dma.c           |   12 ++++++------
 arch/arm/mach-s5pv210/mach-goni.c     |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s5pv210/dma.c b/arch/arm/mach-s5pv210/dma.c
index a6113e0..fc1be6e 100644
--- a/arch/arm/mach-s5pv210/dma.c
+++ b/arch/arm/mach-s5pv210/dma.c
@@ -35,7 +35,7 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-u8 pdma0_peri[] = {
+static u8 pdma0_peri[] = {
 	DMACH_UART0_RX,
 	DMACH_UART0_TX,
 	DMACH_UART1_RX,
@@ -66,12 +66,12 @@ u8 pdma0_peri[] = {
 	DMACH_SPDIF,
 };
 
-struct dma_pl330_platdata s5pv210_pdma0_pdata = {
+static struct dma_pl330_platdata s5pv210_pdma0_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
 	.peri_id = pdma0_peri,
 };
 
-struct amba_device s5pv210_device_pdma0 = {
+static struct amba_device s5pv210_device_pdma0 = {
 	.dev = {
 		.init_name = "dma-pl330.0",
 		.dma_mask = &dma_dmamask,
@@ -87,7 +87,7 @@ struct amba_device s5pv210_device_pdma0 = {
 	.periphid = 0x00041330,
 };
 
-u8 pdma1_peri[] = {
+static u8 pdma1_peri[] = {
 	DMACH_UART0_RX,
 	DMACH_UART0_TX,
 	DMACH_UART1_RX,
@@ -122,12 +122,12 @@ u8 pdma1_peri[] = {
 	DMACH_PCM2_TX,
 };
 
-struct dma_pl330_platdata s5pv210_pdma1_pdata = {
+static struct dma_pl330_platdata s5pv210_pdma1_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
 	.peri_id = pdma1_peri,
 };
 
-struct amba_device s5pv210_device_pdma1 = {
+static struct amba_device s5pv210_device_pdma1 = {
 	.dev = {
 		.init_name = "dma-pl330.1",
 		.dma_mask = &dma_dmamask,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index ff91526..2cf5ed7 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -844,7 +844,7 @@ static struct s5p_fimc_isp_info goni_camera_sensors[] = {
 	},
 };
 
-struct s5p_platform_fimc goni_fimc_md_platdata __initdata = {
+static struct s5p_platform_fimc goni_fimc_md_platdata __initdata = {
 	.isp_info	= goni_camera_sensors,
 	.num_clients	= ARRAY_SIZE(goni_camera_sensors),
 };
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index dff9ea7..0933c8e 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -140,7 +140,7 @@ static struct dm9000_plat_data smdkv210_dm9000_platdata = {
 	.dev_addr	= { 0x00, 0x09, 0xc0, 0xff, 0xec, 0x48 },
 };
 
-struct platform_device smdkv210_dm9000 = {
+static struct platform_device smdkv210_dm9000 = {
 	.name		= "dm9000",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(smdkv210_dm9000_resources),
-- 
1.7.1
