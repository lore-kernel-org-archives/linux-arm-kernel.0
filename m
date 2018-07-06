From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  6 Jul 2018 11:55:21 +0800
Subject: [PATCH v2 4/4] k3dma: delete axi_config
In-Reply-To: <20180706035521.13736-1-guodong.xu@linaro.org>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
Message-ID: <20180706035521.13736-5-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Li Yu <liyu65@hisilicon.com>

Axi_config controls whether DMA resources can be accessed in non-secure
mode, such as linux kernel. The setting is actually done in
bootloader stage.

This patch removes axi_config from k3dma driver.

Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/dma/k3dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 33efb541acb2..4542e703ec85 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -52,8 +52,6 @@
 #define CX_SRC			0x814
 #define CX_DST			0x818
 #define CX_CFG			0x81c
-#define AXI_CFG			0x820
-#define AXI_CFG_DEFAULT		0x201201
 
 #define CX_LLI_CHAIN_EN		0x2
 #define CX_CFG_EN		0x1
@@ -158,7 +156,6 @@ static void k3_dma_set_desc(struct k3_dma_phy *phy, struct k3_desc_hw *hw)
 	writel_relaxed(hw->count, phy->base + CX_CNT0);
 	writel_relaxed(hw->saddr, phy->base + CX_SRC);
 	writel_relaxed(hw->daddr, phy->base + CX_DST);
-	writel_relaxed(AXI_CFG_DEFAULT, phy->base + AXI_CFG);
 	writel_relaxed(hw->config, phy->base + CX_CFG);
 }
 
-- 
2.17.1
