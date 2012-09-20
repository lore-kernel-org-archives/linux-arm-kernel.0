From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:51:44 +0200
Subject: [PATCH 6/6] pinctrl: samsung: Uninline samsung_pinctrl_get_soc_data
In-Reply-To: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
References: <1348131104-24828-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348131104-24828-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although the function is used only a single time, it is not performance
critical and it is pretty heavy, so let the compiler decide whether to
inline it instead.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 8a24223..dd108a9 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -776,7 +776,7 @@ static int __init samsung_gpiolib_unregister(struct platform_device *pdev,
 static const struct of_device_id samsung_pinctrl_dt_match[];
 
 /* retrieve the soc specific data */
-static inline struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
+static struct samsung_pin_ctrl *samsung_pinctrl_get_soc_data(
 				struct platform_device *pdev)
 {
 	int id;
-- 
1.7.12
