From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 29 Jan 2015 15:37:50 -0500
Subject: [PATCH 2/2] soc: ti: knav_qmss_queue: change knav_range_setup_acc_irq
 to static
In-Reply-To: <1422563870-19252-1-git-send-email-m-karicheri2@ti.com>
References: <1422563870-19252-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1422563870-19252-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

knav_range_setup_acc_irq() is used only within the file and should
be defined as static.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/soc/ti/knav_qmss_acc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index 6fbfde6e..ef6f69d 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -209,7 +209,7 @@ static irqreturn_t knav_acc_int_handler(int irq, void *_instdata)
 	return IRQ_HANDLED;
 }
 
-int knav_range_setup_acc_irq(struct knav_range_info *range,
+static int knav_range_setup_acc_irq(struct knav_range_info *range,
 				int queue, bool enabled)
 {
 	struct knav_device *kdev = range->kdev;
-- 
1.7.9.5
