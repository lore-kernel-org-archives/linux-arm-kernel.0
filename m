From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 May 2013 14:29:07 +0100
Subject: [PATCH 7/9] pinctrl: abx500: Specify failed sub-driver by ID instead
 of driver_data
In-Reply-To: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368019749-19455-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a sub-driver has not been specified correctly, there is a good chance
that plat_id is NULL, hence using an attribute of plat_id in the error
message is likely to not only fail the driver but Oops the kernel. Use
the failed ID instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-abx500.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
index aa17f75..2a2a9df 100644
--- a/drivers/pinctrl/pinctrl-abx500.c
+++ b/drivers/pinctrl/pinctrl-abx500.c
@@ -900,8 +900,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 		abx500_pinctrl_ab8505_init(&pct->soc);
 		break;
 	default:
-		dev_err(&pdev->dev, "Unsupported pinctrl sub driver (%d)\n",
-				(int) platid->driver_data);
+		dev_err(&pdev->dev, "Unsupported pinctrl sub driver (%d)\n", id);
 		mutex_destroy(&pct->lock);
 		return -EINVAL;
 	}
-- 
1.7.10.4
