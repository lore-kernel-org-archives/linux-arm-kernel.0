From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 16 Mar 2015 11:19:22 -0700
Subject: [PATCH] ARM: amba: Increase number of IRQs
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Message-ID: <1426529962-2204-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current AMBA bus only allows up to 9 IRQs per device. This is
incorrect, as in peripherals like PL330 can have up to 32 IRQs.
Increase AMBA_NR_IRQS from 9 to 32.

Signed-off-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 include/linux/amba/bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 50fc668..475e090 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -21,7 +21,7 @@
 #include <linux/resource.h>
 #include <linux/regulator/consumer.h>
 
-#define AMBA_NR_IRQS	9
+#define AMBA_NR_IRQS	32
 #define AMBA_CID	0xb105f00d
 #define CORESIGHT_CID	0xb105900d
 
-- 
2.3.3
