From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Nov 2015 21:00:02 +0100
Subject: [PATCH] iio: adc: xilinx: constify iio_buffer_setup_ops structure
Message-ID: <1447617602-12922-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iio_buffer_setup_ops structures are never modified, so declare this one
as const, like the others.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/iio/adc/xilinx-xadc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0370624..c2b5f10 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -803,7 +803,7 @@ err:
 	return ret;
 }
 
-static struct iio_buffer_setup_ops xadc_buffer_ops = {
+static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 	.preenable = &xadc_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
