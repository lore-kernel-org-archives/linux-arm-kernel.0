From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:49 +0100
Subject: [PATCH 11/30] dma: mv_xor: rename mv_xor_shared_platform_data to
 mv_xor_platform_data
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'struct mv_xor_shared_platform_data' used to be the platform_data
structure for the 'mv_xor_shared', but this driver is going to be
renamed simply 'mv_xor', so also rename its platform_data structure
accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/common.c             |    4 ++--
 drivers/dma/mv_xor.c                     |    2 +-
 include/linux/platform_data/dma-mv_xor.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 7ffbe77..edd57a6 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -636,7 +636,7 @@ static struct mv_xor_channel_data orion_xor0_channels_data[2] = {
 	},
 };
 
-static struct mv_xor_shared_platform_data orion_xor0_pdata = {
+static struct mv_xor_platform_data orion_xor0_pdata = {
 	.channels = orion_xor0_channels_data,
 };
 
@@ -711,7 +711,7 @@ static struct mv_xor_channel_data orion_xor1_channels_data[2] = {
 	},
 };
 
-static struct mv_xor_shared_platform_data orion_xor1_pdata = {
+static struct mv_xor_platform_data orion_xor1_pdata = {
 	.channels = orion_xor1_channels_data,
 };
 
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index c7926e4..ac59816 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1254,7 +1254,7 @@ static int mv_xor_shared_probe(struct platform_device *pdev)
 {
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_shared_private *msp;
-	struct mv_xor_shared_platform_data *pdata = pdev->dev.platform_data;
+	struct mv_xor_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res;
 	int i, ret;
 
diff --git a/include/linux/platform_data/dma-mv_xor.h b/include/linux/platform_data/dma-mv_xor.h
index 40ea3d5..82a5f4b 100644
--- a/include/linux/platform_data/dma-mv_xor.h
+++ b/include/linux/platform_data/dma-mv_xor.h
@@ -18,7 +18,7 @@ struct mv_xor_channel_data {
 	size_t				pool_size;
 };
 
-struct mv_xor_shared_platform_data {
+struct mv_xor_platform_data {
 	struct mv_xor_channel_data    *channels;
 };
 
-- 
1.7.9.5
