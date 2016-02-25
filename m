From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Feb 2016 14:23:12 +0100
Subject: [PATCH v2] soc: dove: Make reset_control_ops const
Message-ID: <1456406592-24733-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the pmu_reset_ops structure is never modified, we can make it const
Since commit 203d4f347d86 ("reset: Make reset_control_ops const") marked
the ops pointer in struct reset_controller_dev as const, the pmu_reset_ops
structure, which is never modified, can be made const, too.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
The prerequisite commit is currently sitting in the arm-soc/for-next branch.
Changes since v1:
 - Improved commit message.
---
 drivers/soc/dove/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 039374e..95d77ec 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -87,7 +87,7 @@ static int pmu_reset_deassert(struct reset_controller_dev *rc, unsigned long id)
 	return 0;
 }
 
-static struct reset_control_ops pmu_reset_ops = {
+static const struct reset_control_ops pmu_reset_ops = {
 	.reset = pmu_reset_reset,
 	.assert = pmu_reset_assert,
 	.deassert = pmu_reset_deassert,
-- 
2.7.0
