From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 12 Jun 2014 17:23:22 +0530
Subject: [PATCH V2 14/19] irqchip: crossbar: set cb pointer to null in case of
 error
In-Reply-To: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1402574007-13987-15-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If crossbar_of_init returns with a error, then set the cb pointer
to null.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index cf0d79f..5f3e75a 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -259,6 +259,8 @@ err_base:
 	iounmap(cb->crossbar_base);
 err_cb:
 	kfree(cb);
+
+	cb = NULL;
 	return ret;
 }
 
-- 
1.7.9.5
