From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:13 +0200
Subject: [PATCH 10/11] of: add const to struct of_device_id.data
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-12-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Drivers should never need to modify the data of a device id. So it can
be const which in turn allows more consts in the driver.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/mod_devicetable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5db9382..98fb3fe 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -224,7 +224,7 @@ struct of_device_id
 	char	type[32];
 	char	compatible[128];
 #ifdef __KERNEL__
-	void	*data;
+	const void *data;
 #else
 	kernel_ulong_t data;
 #endif
-- 
1.7.10.4
