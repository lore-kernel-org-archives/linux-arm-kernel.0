From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 29 Jan 2015 15:37:49 -0500
Subject: [PATCH 1/2] soc: ti: knav_qmss_queue: makefile tweak to build as
 dynamic module
Message-ID: <1422563870-19252-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently configuring qmss and dma as dynamic module creates three .ko
files. knav_qmss_acc.ko and knav_qmss_queue.ko both can't be insmod
because of circular dependency. So combine these two into one module
by changing the makefile.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/soc/ti/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index 6bed611..135bdad 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -1,5 +1,6 @@
 #
 # TI Keystone SOC drivers
 #
-obj-$(CONFIG_KEYSTONE_NAVIGATOR_QMSS)	+= knav_qmss_queue.o knav_qmss_acc.o
+obj-$(CONFIG_KEYSTONE_NAVIGATOR_QMSS)	+= knav_qmss.o
+knav_qmss-y := knav_qmss_queue.o knav_qmss_acc.o
 obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
-- 
1.7.9.5
