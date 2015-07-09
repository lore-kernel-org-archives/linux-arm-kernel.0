From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 18:11:32 +0530
Subject: [PATCH 3/3] regulator: 88pm800: Add dev_info to show probe success
 status
In-Reply-To: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436445692-10656-4-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dev_info line at the end of probe function, to
clearly put status of regulator probe on console. Useful during
development, specially to check bootlog.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/regulator/88pm800.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index fdebd23..ee4b370 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -453,6 +453,7 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
+	dev_info(&pdev->dev, "Regulator registered ...\n");
 	return 0;
 }
 
-- 
1.9.1
