From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:13 +0100
Subject: [PATCH 07/19] mfd: sec-core: Fix 'missing blank line after
 declarations' warning
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: Missing a blank line after declarations
+               const struct of_device_id *match;
+               match = of_match_node(sec_dt_match, i2c->dev.of_node);

total: 0 errors, 1 warnings, 494 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/sec-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index fb8ba64..dba7e2b 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -273,6 +273,7 @@ static inline unsigned long sec_i2c_get_driver_data(struct i2c_client *i2c,
 #ifdef CONFIG_OF
 	if (i2c->dev.of_node) {
 		const struct of_device_id *match;
+
 		match = of_match_node(sec_dt_match, i2c->dev.of_node);
 		return (unsigned long)match->data;
 	}
-- 
1.8.3.2
