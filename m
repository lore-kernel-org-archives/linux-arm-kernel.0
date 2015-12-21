From: majun258@huawei.com (MaJun)
Date: Mon, 21 Dec 2015 11:18:25 +0800
Subject: [PATCH] IRQ/Platform-MSI:Increase the maximum MSIs the MSI framework
 can support.
Message-ID: <1450667905-2968-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

The current MSI framework can only support 256 platform MSIs.

But on Hisilicon platform, some network related devices has about 500
wired interrupts.

To support these devices, we need a new maximum value more than 256.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/base/platform-msi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index a203896..9c00d3f 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -24,7 +24,7 @@
 #include <linux/msi.h>
 #include <linux/slab.h>
 
-#define DEV_ID_SHIFT	24
+#define DEV_ID_SHIFT	22
 #define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
 
 /*
-- 
1.7.1
