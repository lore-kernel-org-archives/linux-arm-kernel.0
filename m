From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 24 Mar 2016 11:23:51 +0000
Subject: [PATCH 2/3] [media] c8sectpfe: Demote print to dev_dbg
In-Reply-To: <1458818632-25552-1-git-send-email-peter.griffin@linaro.org>
References: <1458818632-25552-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1458818632-25552-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 875d384..acd0767 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -585,7 +585,7 @@ static int configure_memdma_and_inputblock(struct c8sectpfei *fei,
 	writel(tsin->pid_buffer_busaddr,
 		fei->io + PIDF_BASE(tsin->tsin_id));
 
-	dev_info(fei->dev, "chan=%d PIDF_BASE=0x%x pid_bus_addr=%pad\n",
+	dev_dbg(fei->dev, "chan=%d PIDF_BASE=0x%x pid_bus_addr=%pad\n",
 		tsin->tsin_id, readl(fei->io + PIDF_BASE(tsin->tsin_id)),
 		&tsin->pid_buffer_busaddr);
 
-- 
1.9.1
