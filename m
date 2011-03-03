From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 Mar 2011 15:47:23 +0530
Subject: [PATCH V2 10/13] dw_dmac: Changing type of src_master and dest_master
	to u8.
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <ec99139f828ed619a28723dc536c3ef38b0af1c3.1299146382.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

src_master & dest_master don't required u32 as they have values limited to u8
only. Also their description is missing from doc style comment. This patch
fixes above mentioned issues.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/dw_dmac.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/dw_dmac.h b/include/linux/dw_dmac.h
index 64c76da..3ba2f06 100644
--- a/include/linux/dw_dmac.h
+++ b/include/linux/dw_dmac.h
@@ -53,6 +53,8 @@ enum dw_dma_slave_width {
  * @reg_width: peripheral register width
  * @cfg_hi: Platform-specific initializer for the CFG_HI register
  * @cfg_lo: Platform-specific initializer for the CFG_LO register
+ * @src_master: src master for transfers on allocated channel.
+ * @dst_master: dest master for transfers on allocated channel.
  */
 struct dw_dma_slave {
 	struct device		*dma_dev;
@@ -61,8 +63,8 @@ struct dw_dma_slave {
 	enum dw_dma_slave_width	reg_width;
 	u32			cfg_hi;
 	u32			cfg_lo;
-	int			src_master;
-	int			dst_master;
+	u8			src_master;
+	u8			dst_master;
 };
 
 /* Platform-configurable bits in CFG_HI */
-- 
1.7.2.2
