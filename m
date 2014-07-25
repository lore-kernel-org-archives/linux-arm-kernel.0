From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 25 Jul 2014 15:23:50 +0100
Subject: [PATCH 2/5] char: tile-srom: Remove reference to platform_bus
In-Reply-To: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1406298233-27876-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code was creating "srom" class devices using
platform_bus as a parent. As they are not really
platform devices, make them virtual, using NULL instead.

Cc: Chris Metcalf <cmetcalf@tilera.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/char/tile-srom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tile-srom.c b/drivers/char/tile-srom.c
index bd37747..be88699 100644
--- a/drivers/char/tile-srom.c
+++ b/drivers/char/tile-srom.c
@@ -350,7 +350,7 @@ static int srom_setup_minor(struct srom_dev *srom, int index)
 		       SROM_PAGE_SIZE_OFF, sizeof(srom->page_size)) < 0)
 		return -EIO;
 
-	dev = device_create(srom_class, &platform_bus,
+	dev = device_create(srom_class, NULL,
 			    MKDEV(srom_major, index), srom, "%d", index);
 	return PTR_ERR_OR_ZERO(dev);
 }
-- 
1.9.1
