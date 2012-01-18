From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 18 Jan 2012 14:41:53 +0530
Subject: [PATCH V2 06/12] dmaengine/dw_dmac: Use dev_get_platdata() instead of
 accessing dev directly
In-Reply-To: <cover.1326876464.git.viresh.kumar@st.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
Message-ID: <7ee05856ef8235eeb31bea1b5ab2e898037d9ffd.1326876464.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use already defined function dev_get_platdata() instead of accessing
pdev->dev.data.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 1577394..f3aecb3 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1369,7 +1369,7 @@ static int __init dw_probe(struct platform_device *pdev)
 	int			err;
 	int			i;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata || pdata->nr_channels > DW_DMA_MAX_NR_CHANNELS)
 		return -EINVAL;
 
-- 
1.7.8.110.g4cb5d
