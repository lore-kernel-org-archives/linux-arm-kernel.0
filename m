From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 5 Jul 2016 10:11:03 +0800
Subject: [PATCH 1/2] hwspinlock: qcom_hwspinlock: add missing of_node_put
 after calling of_parse_phandle
Message-ID: <1467684664-21155-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index c752447..fa6880b 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -98,6 +98,7 @@ static int qcom_hwspinlock_probe(struct platform_device *pdev)
 	}
 
 	regmap = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
1.9.1
