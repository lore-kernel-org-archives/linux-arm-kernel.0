From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 09:58:32 +0900
Subject: [PATCH 4/5] ARM: S5P: Reorder DMA platform device id
In-Reply-To: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
References: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1287622713-1657-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Seungwhan Youn <sw.youn@samsung.com>

This patch is matched-up DMA platform device id to it's clock id.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
Acked-by: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/dma.c |    2 +-
 arch/arm/mach-s5p64x0/dma.c |    2 +-
 arch/arm/mach-s5pc100/dma.c |    4 ++--
 arch/arm/mach-s5pv210/dma.c |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5p6442/dma.c b/arch/arm/mach-s5p6442/dma.c
index ad4f870..7dfb136 100644
--- a/arch/arm/mach-s5p6442/dma.c
+++ b/arch/arm/mach-s5p6442/dma.c
@@ -82,7 +82,7 @@ static struct s3c_pl330_platdata s5p6442_pdma_pdata = {
 
 static struct platform_device s5p6442_device_pdma = {
 	.name		= "s3c-pl330",
-	.id		= 1,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(s5p6442_pdma_resource),
 	.resource	= s5p6442_pdma_resource,
 	.dev		= {
diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
index 29a8c24..d7ad944 100644
--- a/arch/arm/mach-s5p64x0/dma.c
+++ b/arch/arm/mach-s5p64x0/dma.c
@@ -122,7 +122,7 @@ static struct s3c_pl330_platdata s5p6450_pdma_pdata = {
 
 static struct platform_device s5p64x0_device_pdma = {
 	.name		= "s3c-pl330",
-	.id		= 0,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(s5p64x0_pdma_resource),
 	.resource	= s5p64x0_pdma_resource,
 	.dev		= {
diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
index 0f55175..bf4cd0f 100644
--- a/arch/arm/mach-s5pc100/dma.c
+++ b/arch/arm/mach-s5pc100/dma.c
@@ -81,7 +81,7 @@ static struct s3c_pl330_platdata s5pc100_pdma0_pdata = {
 
 static struct platform_device s5pc100_device_pdma0 = {
 	.name		= "s3c-pl330",
-	.id		= 1,
+	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s5pc100_pdma0_resource),
 	.resource	= s5pc100_pdma0_resource,
 	.dev		= {
@@ -143,7 +143,7 @@ static struct s3c_pl330_platdata s5pc100_pdma1_pdata = {
 
 static struct platform_device s5pc100_device_pdma1 = {
 	.name		= "s3c-pl330",
-	.id		= 2,
+	.id		= 1,
 	.num_resources	= ARRAY_SIZE(s5pc100_pdma1_resource),
 	.resource	= s5pc100_pdma1_resource,
 	.dev		= {
diff --git a/arch/arm/mach-s5pv210/dma.c b/arch/arm/mach-s5pv210/dma.c
index 778ad5f..497d343 100644
--- a/arch/arm/mach-s5pv210/dma.c
+++ b/arch/arm/mach-s5pv210/dma.c
@@ -82,7 +82,7 @@ static struct s3c_pl330_platdata s5pv210_pdma0_pdata = {
 
 static struct platform_device s5pv210_device_pdma0 = {
 	.name		= "s3c-pl330",
-	.id		= 1,
+	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s5pv210_pdma0_resource),
 	.resource	= s5pv210_pdma0_resource,
 	.dev		= {
@@ -144,7 +144,7 @@ static struct s3c_pl330_platdata s5pv210_pdma1_pdata = {
 
 static struct platform_device s5pv210_device_pdma1 = {
 	.name		= "s3c-pl330",
-	.id		= 2,
+	.id		= 1,
 	.num_resources	= ARRAY_SIZE(s5pv210_pdma1_resource),
 	.resource	= s5pv210_pdma1_resource,
 	.dev		= {
-- 
1.6.2.5
