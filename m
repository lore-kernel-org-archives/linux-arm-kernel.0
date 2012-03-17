From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 17 Mar 2012 09:17:49 +0000
Subject: [PATCH] drivers/base: fix compiler warning in SoC export driver -
 idr should be ida
Message-ID: <4F6456BD.9080205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:
  note: expected ?struct ida *? but argument is of type ?struct idr *?
  warning: passing argument 1 of ?ida_pre_get? from incompatible pointer type

Reported-by: Arnd Bergman <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/base/soc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 05f1503..e57aec1 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -15,7 +15,7 @@
 #include <linux/sys_soc.h>
 #include <linux/err.h>
 
-static DEFINE_IDR(soc_ida);
+static DEFINE_IDA(soc_ida);
 static DEFINE_SPINLOCK(soc_lock);
 
 static ssize_t soc_info_get(struct device *dev,
-- 
1.7.5.4
