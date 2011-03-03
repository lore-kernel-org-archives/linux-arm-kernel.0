From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 Mar 2011 15:47:19 +0530
Subject: [PATCH V2 06/13] dw_dmac: Change value of DWC_MAX_COUNT to 4095.
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <0e767d5a3f538e476b72c7d5ccac88e2f5fcdf1a.1299146382.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every descriptor can transfer a maximum count of 4095 (12 bits, in control reg),
So we must have DWC_MAX_COUNT as 4095 instead of 2048 for better performance.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index e5d97bf..734829f 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -47,14 +47,13 @@
 
 /*
  * This is configuration-dependent and usually a funny size like 4095.
- * Let's round it down to the nearest power of two.
  *
  * Note that this is a transfer count, i.e. if we transfer 32-bit
- * words, we can do 8192 bytes per descriptor.
+ * words, we can do 16480 bytes per descriptor.
  *
  * This parameter is also system-specific.
  */
-#define DWC_MAX_COUNT	2048U
+#define DWC_MAX_COUNT	4095U
 
 /*
  * Number of descriptors to allocate for each channel. This should be
-- 
1.7.2.2
