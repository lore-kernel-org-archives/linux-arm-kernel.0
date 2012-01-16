From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Jan 2012 15:20:32 +0530
Subject: [PATCH 4/8] dmaengine/dw_dmac: Don't use magic number for total
 number of channels
In-Reply-To: <cover.1326707233.git.viresh.kumar@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
Message-ID: <4b7b48a3d581c7e44f494f888f6eb04b6bf52512.1326707233.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Total number of channels is passed in pdata->nr_channels variable, thus we must
not use magic number '7' for total number of channels.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 3a3d7ed..1577394 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1432,7 +1432,7 @@ static int __init dw_probe(struct platform_device *pdev)
 
 		/* 7 is highest priority & 0 is lowest. */
 		if (pdata->chan_priority == CHAN_PRIORITY_ASCENDING)
-			dwc->priority = 7 - i;
+			dwc->priority = pdata->nr_channels - i - 1;
 		else
 			dwc->priority = i;
 
-- 
1.7.8.110.g4cb5d
