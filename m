From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Fri, 17 Nov 2017 15:38:27 +0200
Subject: [PATCH 03/10] staging: fsl-mc/dpio: drop EXPORT_SYMBOL() for a few
 functions
In-Reply-To: <20171117133834.4635-1-laurentiu.tudor@nxp.com>
References: <20171117133834.4635-1-laurentiu.tudor@nxp.com>
Message-ID: <20171117133834.4635-3-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

These functions are only used within this driver so no need for
EXPORT_SYMBOL().

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index 591d8b7..fca8c90dc 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -156,7 +156,6 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
 
 	return obj;
 }
-EXPORT_SYMBOL(dpaa2_io_create);
 
 /**
  * dpaa2_io_down() - release the dpaa2_io object.
@@ -171,7 +170,6 @@ void dpaa2_io_down(struct dpaa2_io *d)
 {
 	kfree(d);
 }
-EXPORT_SYMBOL(dpaa2_io_down);
 
 #define DPAA_POLL_MAX 32
 
@@ -218,7 +216,6 @@ irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
 	qbman_swp_interrupt_set_inhibit(swp, 0);
 	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL(dpaa2_io_irq);
 
 /**
  * dpaa2_io_service_register() - Prepare for servicing of FQDAN or CDAN
-- 
2.9.4
