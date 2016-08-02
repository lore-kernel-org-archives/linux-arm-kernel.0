From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:42:56 +0800
Subject: [PATCH 0130/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802104256.22416-1-baolex.ni@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/crypto/picoxcell_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 3b1c7ec..e535d10 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1224,7 +1224,7 @@ static ssize_t spacc_stat_irq_thresh_store(struct device *dev,
 
 	return len;
 }
-static DEVICE_ATTR(stat_irq_thresh, 0644, spacc_stat_irq_thresh_show,
+static DEVICE_ATTR(stat_irq_thresh, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, spacc_stat_irq_thresh_show,
 		   spacc_stat_irq_thresh_store);
 
 static struct spacc_alg ipsec_engine_algs[] = {
-- 
2.9.2
