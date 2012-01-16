From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Jan 2012 15:20:33 +0530
Subject: [PATCH 5/8] dmaengine/dw_dmac: Use platform_get_drvdata instead of
 accessing dev directly
In-Reply-To: <cover.1326707233.git.viresh.kumar@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
Message-ID: <51d3263224d48c1d68de1449af28fb1570900254.1326707233.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use already defined function platform_get_drvdata() instead of accessing
pdev->dev.data.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 1577394..f061daa 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1369,7 +1369,7 @@ static int __init dw_probe(struct platform_device *pdev)
 	int			err;
 	int			i;
 
-	pdata = pdev->dev.platform_data;
+	pdata = platform_get_drvdata(pdev);
 	if (!pdata || pdata->nr_channels > DW_DMA_MAX_NR_CHANNELS)
 		return -EINVAL;
 
-- 
1.7.8.110.g4cb5d
