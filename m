From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:09 +0100
Subject: [PATCH 03/19] mfd: tps80031: Fix 'missing break or fall-through
 comment' warning
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: Possible switch case/default not preceeded by break or fallthrough comment
+       case TPS80031_BACKUP_REG:

total: 0 errors, 1 warnings, 573 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/tps80031.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps80031.c b/drivers/mfd/tps80031.c
index ed6c5b0..7a3806c 100644
--- a/drivers/mfd/tps80031.c
+++ b/drivers/mfd/tps80031.c
@@ -334,6 +334,7 @@ static bool rd_wr_reg_id1(struct device *dev, unsigned int reg)
 	case TPS80031_PREQ1_RES_ASS_A ... TPS80031_PREQ3_RES_ASS_C:
 	case TPS80031_SMPS_OFFSET ... TPS80031_BATDEBOUNCING:
 	case TPS80031_CFG_INPUT_PUPD1 ... TPS80031_CFG_SMPS_PD:
+		/* Fall through */
 	case TPS80031_BACKUP_REG:
 		return true;
 	default:
-- 
1.8.3.2
