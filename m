From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 11 May 2018 18:20:17 +0200
Subject: [PATCH 01/12] platform/early: add a new field to struct device
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Message-ID: <20180511162028.20616-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a new single-bit field to struct device which will be used to
indicate that a device was probed early in the boot sequence.

This does not affect the size of struct device on any architecture
I built on (ARM, ARM64, x86_64).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 477956990f5e..bcff8b598b20 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -992,6 +992,7 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
+	bool			early:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
-- 
2.17.0
