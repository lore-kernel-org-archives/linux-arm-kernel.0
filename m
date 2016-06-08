From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  8 Jun 2016 10:10:03 +0100
Subject: [PATCH v2 2/2] phy: phy-qcom-ufs-qmp-20nm: Remove site specific OOM
 error message
In-Reply-To: <1465377003-25660-1-git-send-email-peter.griffin@linaro.org>
References: <1465377003-25660-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1465377003-25660-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kzalloc will issue its own error message including a dump_stack()
so remote the site specific message.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

---

v2: Add brackets, so goto is not executed unconditionally (Baruch)
---
 drivers/phy/phy-qcom-ufs-qmp-20nm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/phy-qcom-ufs-qmp-20nm.c b/drivers/phy/phy-qcom-ufs-qmp-20nm.c
index b16ea77..770087a 100644
--- a/drivers/phy/phy-qcom-ufs-qmp-20nm.c
+++ b/drivers/phy/phy-qcom-ufs-qmp-20nm.c
@@ -196,7 +196,6 @@ static int ufs_qcom_phy_qmp_20nm_probe(struct platform_device *pdev)
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy) {
-		dev_err(dev, "%s: failed to allocate phy\n", __func__);
 		err = -ENOMEM;
 		goto out;
 	}
-- 
1.9.1
