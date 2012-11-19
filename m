From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:47 +0100
Subject: [PATCH 09/30] dma: mv_xor: remove 'shared' from mv_xor_platform_data
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This member of the platform_data structure is no longer used, so get
rid of it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/common.c             |    8 --------
 include/linux/platform_data/dma-mv_xor.h |    1 -
 2 files changed, 9 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index c6e6666..5a66211 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -625,16 +625,12 @@ static struct resource orion_xor0_shared_resources[] = {
 	},
 };
 
-static struct platform_device orion_xor0_shared;
-
 static struct mv_xor_platform_data orion_xor0_channels_pdata[2] = {
 	{
-		.shared		= &orion_xor0_shared,
 		.hw_id		= 0,
 		.pool_size	= PAGE_SIZE,
 	},
 	{
-		.shared		= &orion_xor0_shared,
 		.hw_id		= 1,
 		.pool_size	= PAGE_SIZE,
 	},
@@ -704,16 +700,12 @@ static struct resource orion_xor1_shared_resources[] = {
 	},
 };
 
-static struct platform_device orion_xor1_shared;
-
 static struct mv_xor_platform_data orion_xor1_channels_pdata[2] = {
 	{
-		.shared		= &orion_xor1_shared,
 		.hw_id		= 0,
 		.pool_size	= PAGE_SIZE,
 	},
 	{
-		.shared		= &orion_xor1_shared,
 		.hw_id		= 1,
 		.pool_size	= PAGE_SIZE,
 	},
diff --git a/include/linux/platform_data/dma-mv_xor.h b/include/linux/platform_data/dma-mv_xor.h
index 6abe5f9..4a0980b 100644
--- a/include/linux/platform_data/dma-mv_xor.h
+++ b/include/linux/platform_data/dma-mv_xor.h
@@ -13,7 +13,6 @@
 #define MV_XOR_SHARED_NAME	"mv_xor_shared"
 
 struct mv_xor_platform_data {
-	struct platform_device		*shared;
 	int				hw_id;
 	dma_cap_mask_t			cap_mask;
 	size_t				pool_size;
-- 
1.7.9.5
