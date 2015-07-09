From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 18:11:31 +0530
Subject: [PATCH 2/3] regulator: 88pm800: fix LDO vsel_mask value
In-Reply-To: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436445692-10656-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yi Zhang <yizhang@marvell.com>

As per datasheet,
Except LDO2, all other LDO's use bit [3:0] for VOUT select.

Current code uses wrong mask value of 0x1f, So this patch
fixes it to use 0xf.

Signed-off-by: Yi Zhang <yizhang@marvell.com>
[vaibhav.hiremath at linaro.org: Updated changelog with more detailed description]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/regulator/88pm800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index d22a098..fdebd23 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -137,7 +137,7 @@ struct pm800_regulators {
 		.owner	= THIS_MODULE,					\
 		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
 		.vsel_reg	= PM800_##vreg##_VOUT,			\
-		.vsel_mask	= 0x1f,					\
+		.vsel_mask	= 0xf,					\
 		.enable_reg	= PM800_##ereg,				\
 		.enable_mask	= 1 << (ebit),				\
 		.volt_table	= ldo_volt_table,			\
-- 
1.9.1
