From: rajeev-dlh.kumar@st.com (Rajeev Kumar)
Date: Wed, 11 Jan 2012 11:53:09 +0530
Subject: [PATCH] dmaengine/dw_dmac: Hibernation support in dw_dmac
Message-ID: <1326262989-18608-1-git-send-email-rajeev-dlh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The suspend and resume implementation is through dev_pm_ops in dmac. So
in order to support hibernation, freeze, thaw and restore features are required.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index d2e1c25..cb346d6 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1568,6 +1568,9 @@ static int dw_resume_noirq(struct device *dev)
 static const struct dev_pm_ops dw_dev_pm_ops = {
 	.suspend_noirq = dw_suspend_noirq,
 	.resume_noirq = dw_resume_noirq,
+	.freeze_noirq = dw_suspend_noirq,
+	.thaw_noirq =	dw_resume_noirq,
+	.restore_noirq = dw_resume_noirq,
 };
 
 static struct platform_driver dw_driver = {
-- 
1.6.0.2
