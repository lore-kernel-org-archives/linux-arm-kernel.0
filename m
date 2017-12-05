From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:16:35 +0100
Subject: [PATCH 01/12] firmware: arm_scpi: remove two unneeded devm_kfree's in
 scpi_remove
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <14a7fdfe-a854-0fe7-bf4b-f7e62a001c2e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both memory areas are free'd anyway when the device is destroyed,
so we don't have to do it manually. 

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 7da9f1b8..2a30d255 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -918,8 +918,6 @@ static int scpi_remove(struct platform_device *pdev)
 		kfree(info->dvfs[i]->opps);
 		kfree(info->dvfs[i]);
 	}
-	devm_kfree(dev, info->channels);
-	devm_kfree(dev, info);
 
 	return 0;
 }
-- 
2.15.1
