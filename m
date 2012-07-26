From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 11:28:35 +0100
Subject: [PATCH 02/21] MFD: db8500-prcmu: Ensure AB8500 platform data is
 passed through MFD Core
In-Reply-To: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343298534-13611-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting via platform code the AB8500 platform data is now passed
in though the DB8500. However, if pdata_size is not set it will not be
subsequently passed onto subordinate devices. This patch correctly
populates pdata_size.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 4050a1e..7040a00 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3002,6 +3002,7 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(db8500_prcmu_devs); i++) {
 		if (!strcmp(db8500_prcmu_devs[i].name, "ab8500-core")) {
 			db8500_prcmu_devs[i].platform_data = ab8500_platdata;
+			db8500_prcmu_devs[i].pdata_size = sizeof(struct ab8500_platform_data);
 		}
 	}
 
-- 
1.7.9.5
