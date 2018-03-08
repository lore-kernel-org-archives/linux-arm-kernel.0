From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu,  8 Mar 2018 18:21:52 +0800
Subject: [PATCH v3 2/4] rtc: at91sam9: Pass pdev->dev to regmap_init_mmio()
In-Reply-To: <20180308102154.25686-1-jeffy.chen@rock-chips.com>
References: <20180308102154.25686-1-jeffy.chen@rock-chips.com>
Message-ID: <20180308102154.25686-3-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise it would use "dummy*" to create regmap debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None

 drivers/rtc/rtc-at91sam9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 7418a763ce52..0d6a17a77841 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -402,7 +402,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 		if (IS_ERR(gpbr))
 			return PTR_ERR(gpbr);
 
-		rtc->gpbr = regmap_init_mmio(NULL, gpbr,
+		rtc->gpbr = regmap_init_mmio(&pdev->dev, gpbr,
 					     &gpbr_regmap_config);
 	} else {
 		struct of_phandle_args args;
-- 
2.11.0
