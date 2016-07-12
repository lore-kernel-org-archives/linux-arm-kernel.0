From: henryc.chen@mediatek.com (Henry Chen)
Date: Tue, 12 Jul 2016 17:44:36 +0800
Subject: [PATCH] soc: mediatek: PMIC wrap: Extend th wainting time to 10ms.
Message-ID: <1468316676-14901-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read data fails sometimes because of a timeout that PMIC cannot transfer data
to PMIC wrap on time, extend the wainting time to 10ms to reduce the failed
rate.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index a003ba2..a5f1093 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -583,7 +583,7 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
 {
 	unsigned long timeout;
 
-	timeout = jiffies + usecs_to_jiffies(255);
+	timeout = jiffies + usecs_to_jiffies(10000);
 
 	do {
 		if (time_after(jiffies, timeout))
-- 
1.8.1.1.dirty
