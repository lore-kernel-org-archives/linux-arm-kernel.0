From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 1 Feb 2012 16:12:17 +0530
Subject: [PATCH V3 01/12] dmaengine/dw_dmac: Hibernation support in dw_dmac
In-Reply-To: <cover.1328091915.git.viresh.kumar@st.com>
References: <cover.1328091915.git.viresh.kumar@st.com>
Message-ID: <91f435464b40009113ddc3d2287f10d81e498654.1328091915.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajeev KUMAR <rajeev-dlh.kumar@st.com>

The suspend and resume implementation is through dev_pm_ops in dmac. So
in order to support hibernation, freeze, thaw, restore and poweroff
features are required.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Acked-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 9b592b0..3a3d7ed 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1562,6 +1562,10 @@ static int dw_resume_noirq(struct device *dev)
 static const struct dev_pm_ops dw_dev_pm_ops = {
 	.suspend_noirq = dw_suspend_noirq,
 	.resume_noirq = dw_resume_noirq,
+	.freeze_noirq = dw_suspend_noirq,
+	.thaw_noirq = dw_resume_noirq,
+	.restore_noirq = dw_resume_noirq,
+	.poweroff_noirq = dw_suspend_noirq,
 };
 
 static struct platform_driver dw_driver = {
-- 
1.7.8.110.g4cb5d
