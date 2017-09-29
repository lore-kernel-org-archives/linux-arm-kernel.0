From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 29 Sep 2017 23:44:01 +0200
Subject: [PATCH 2/5] firmware: arm_scpi: remove two unneeded devm_kfree's in
 scpi_remove
In-Reply-To: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
Message-ID: <16d143b8-b8a9-d456-dd38-84131e3a5bd9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both memory areas are free'd anyway when the device is destroyed,
so we don't have to do it manually.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index c942761e..d80d11ae 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -914,8 +914,6 @@ static int scpi_remove(struct platform_device *pdev)
 		kfree(scpi_info->dvfs[i]->opps);
 		kfree(scpi_info->dvfs[i]);
 	}
-	devm_kfree(dev, scpi_info->channels);
-	devm_kfree(dev, scpi_info);
 
 	return 0;
 }
-- 
2.14.2
