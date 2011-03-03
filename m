From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 Mar 2011 15:47:25 +0530
Subject: [PATCH V2 12/13] dw_dmac: Setting Default Burst length for transfers
	as 16.
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <4f478a7a897ffead93f71574f74b178533dde647.1299146382.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets default Burst length for all transfer to 16. This will
enhance performance when user doesn't have any chan->private data.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 5f5b28b..cf07539 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -36,8 +36,8 @@
 		struct dw_dma_slave *__slave = (private);	\
 		int dms = __slave ? __slave->dst_master : 0;	\
 		int sms = __slave ? __slave->src_master : 1;	\
-		u8 smsize = __slave ? __slave->src_msize : 0;	\
-		u8 dmsize = __slave ? __slave->dst_msize : 0;	\
+		u8 smsize = __slave ? __slave->src_msize : DW_DMA_MSIZE_16; \
+		u8 dmsize = __slave ? __slave->dst_msize : DW_DMA_MSIZE_16; \
 								\
 		(DWC_CTLL_DST_MSIZE(dmsize)			\
 		 | DWC_CTLL_SRC_MSIZE(smsize)			\
-- 
1.7.2.2
