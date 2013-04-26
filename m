From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 26 Apr 2013 14:17:14 +0200
Subject: [PATCH 1/5] mfd: abx500-core: fix sparse warning
In-Reply-To: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
References: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1366978638-967-2-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix sparse warning:

drivers/mfd/abx500-core.c:159:38: warning: Using plain integer as NULL pointer

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/mfd/abx500-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index 9818afb..3714acb 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -156,7 +156,7 @@ EXPORT_SYMBOL(abx500_startup_irq_enabled);
 void abx500_dump_all_banks(void)
 {
 	struct abx500_ops *ops;
-	struct device dummy_child = {0};
+	struct device dummy_child = {NULL};
 	struct abx500_device_entry *dev_entry;
 
 	list_for_each_entry(dev_entry, &abx500_list, list) {
-- 
1.8.1.3
