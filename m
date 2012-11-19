From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:45 +0100
Subject: [PATCH 07/30] arm: plat-orion: remove unused orion_xor_init_channels()
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that xor0 and xor1 are registered in a single driver manner, the
orion_xor_init_channels() function has become useless.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/common.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index afbbb97..c6e6666 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -606,26 +606,6 @@ void __init orion_wdt_init(void)
  ****************************************************************************/
 static u64 orion_xor_dmamask = DMA_BIT_MASK(32);
 
-void __init orion_xor_init_channels(
-	struct mv_xor_platform_data *orion_xor0_data,
-	struct platform_device *orion_xor0_channel,
-	struct mv_xor_platform_data *orion_xor1_data,
-	struct platform_device *orion_xor1_channel)
-{
-	/*
-	 * two engines can't do memset simultaneously, this limitation
-	 * satisfied by removing memset support from one of the engines.
-	 */
-	dma_cap_set(DMA_MEMCPY, orion_xor0_data->cap_mask);
-	dma_cap_set(DMA_XOR, orion_xor0_data->cap_mask);
-	platform_device_register(orion_xor0_channel);
-
-	dma_cap_set(DMA_MEMCPY, orion_xor1_data->cap_mask);
-	dma_cap_set(DMA_MEMSET, orion_xor1_data->cap_mask);
-	dma_cap_set(DMA_XOR, orion_xor1_data->cap_mask);
-	platform_device_register(orion_xor1_channel);
-}
-
 /*****************************************************************************
  * XOR0
  ****************************************************************************/
-- 
1.7.9.5
