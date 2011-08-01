From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 1 Aug 2011 15:07:15 +0530
Subject: [PATCH V2 05/20] dmaengine/amba-pl08x: Complete doc comment for
	struct pl08x_txd
In-Reply-To: <cover.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
Message-ID: <fc93aa2f373943b30d251d540f41b1acc8b9e438.1312190881.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doc comment for struct pl08x_txd was incomplete. Complete that.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/amba/pl08x.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index e6e28f3..cd8f629 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -105,8 +105,16 @@ struct pl08x_phy_chan {
 
 /**
  * struct pl08x_txd - wrapper for struct dma_async_tx_descriptor
+ * @tx: async tx descriptor
+ * @node: node for txd list for channels
+ * @src_addr: src address of txd
+ * @dst_addr: dst address of txd
+ * @len: transfer len in bytes
+ * @direction: direction of transfer
  * @llis_bus: DMA memory address (physical) start for the LLIs
  * @llis_va: virtual memory address start for the LLIs
+ * @cctl: control reg values for current txd
+ * @ccfg: config reg values for current txd
  */
 struct pl08x_txd {
 	struct dma_async_tx_descriptor tx;
-- 
1.7.2.2
