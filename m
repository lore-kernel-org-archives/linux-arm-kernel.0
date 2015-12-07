From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:30 +0000
Subject: [PATCH 17/19] mfd: da9052-i2c: Fix tabbing/whitespace issue
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: suspect code indent for conditional statements (8, 24)
+       if (!i2c_safe_reg(reg))
+                       return regmap_read(da9052->regmap,

total: 0 errors, 1 warnings, 226 lines checked

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/da9052-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 0288700..d2feaa1 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -70,7 +70,7 @@ static int da9052_i2c_fix(struct da9052 *da9052, unsigned char reg)
 	case DA9053_BA:
 	case DA9053_BB:
 		/* A dummy read to a safe register address. */
-	if (!i2c_safe_reg(reg))
+		if (!i2c_safe_reg(reg))
 			return regmap_read(da9052->regmap,
 					   DA9052_PARK_REGISTER,
 					   &val);
-- 
1.9.1
