From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 23 Dec 2015 11:59:25 +0100
Subject: [PATCH v5 2/5] ARM: sa1111: ensure no negative value gets returned on
 positive match
In-Reply-To: <1450868368-5650-1-git-send-email-m.szyprowski@samsung.com>
References: <1450868368-5650-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1450868368-5650-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch ensures that existing bus match callbacks don't return
negative values (which might be interpreted as potential errors in the
future) in case of positive match.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/common/sa1111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 3d22494..fb0a0a4 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1290,7 +1290,7 @@ static int sa1111_match(struct device *_dev, struct device_driver *_drv)
 	struct sa1111_dev *dev = SA1111_DEV(_dev);
 	struct sa1111_driver *drv = SA1111_DRV(_drv);
 
-	return dev->devid & drv->devid;
+	return !!(dev->devid & drv->devid);
 }
 
 static int sa1111_bus_suspend(struct device *dev, pm_message_t state)
-- 
1.9.2
