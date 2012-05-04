From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:20 +0100
Subject: [PATCH 10/15] drivers/mfd: db8500-prcmu: Add support for regulator
 supply for nmk-i2c.4
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This applies a supply alias for the db8500's fifth Nomadik i2c port.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 9bc75a8..d534449 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2720,6 +2720,7 @@ static struct regulator_consumer_supply db8500_vape_consumers[] = {
 	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.1"),
 	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.2"),
 	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.3"),
+	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.4"),
 	/* "v-mmc" changed to "vcore" in the mainline kernel */
 	REGULATOR_SUPPLY("vcore", "sdi0"),
 	REGULATOR_SUPPLY("vcore", "sdi1"),
-- 
1.7.9.5
