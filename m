From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 14:14:14 +0100
Subject: [PATCH 08/11] mfd: max77686: Remove check which is always true
In-Reply-To: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
References: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409231657-18294-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As 'reg' is unsigned, it can't be less than 0, so checking if it is
greater than or equal to 0 will always result in a true condition.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/max77686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 86e5523..929795e 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -52,7 +52,7 @@ static const struct mfd_cell max77802_devs[] = {
 static bool max77802_pmic_is_accessible_reg(struct device *dev,
 					    unsigned int reg)
 {
-	return (reg >= MAX77802_REG_DEVICE_ID && reg < MAX77802_REG_PMIC_END);
+	return reg < MAX77802_REG_PMIC_END;
 }
 
 static bool max77802_rtc_is_accessible_reg(struct device *dev,
-- 
1.9.1
