From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 19 May 2013 22:12:43 +0200
Subject: [PATCH] ARM: plat-orion: Fix num_resources and id for ge10 and ge11
Message-ID: <1368994363-14762-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When platform data were moved from arch/arm/mach-mv78xx0/common.c to
arch/arm/plat-orion/common.c with the commit "7e3819d ARM: orion:
Consolidate ethernet platform data", there were few typo made on
gigabit Ethernet interface ge10 and ge11. This commit writes back
their initial value, which allows to use this interfaces again.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/plat-orion/common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 251f827..c019b7a 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -383,7 +383,7 @@ static struct resource orion_ge10_shared_resources[] = {
 
 static struct platform_device orion_ge10_shared = {
 	.name		= MV643XX_ETH_SHARED_NAME,
-	.id		= 1,
+	.id		= 2,
 	.dev		= {
 		.platform_data	= &orion_ge10_shared_data,
 	},
@@ -398,8 +398,8 @@ static struct resource orion_ge10_resources[] = {
 
 static struct platform_device orion_ge10 = {
 	.name		= MV643XX_ETH_NAME,
-	.id		= 1,
-	.num_resources	= 2,
+	.id		= 2,
+	.num_resources	= 1,
 	.resource	= orion_ge10_resources,
 	.dev		= {
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
@@ -432,7 +432,7 @@ static struct resource orion_ge11_shared_resources[] = {
 
 static struct platform_device orion_ge11_shared = {
 	.name		= MV643XX_ETH_SHARED_NAME,
-	.id		= 1,
+	.id		= 3,
 	.dev		= {
 		.platform_data	= &orion_ge11_shared_data,
 	},
@@ -447,8 +447,8 @@ static struct resource orion_ge11_resources[] = {
 
 static struct platform_device orion_ge11 = {
 	.name		= MV643XX_ETH_NAME,
-	.id		= 1,
-	.num_resources	= 2,
+	.id		= 3,
+	.num_resources	= 1,
 	.resource	= orion_ge11_resources,
 	.dev		= {
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
-- 
1.8.1.2
