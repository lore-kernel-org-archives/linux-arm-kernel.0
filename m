From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 Jul 2015 15:34:11 -0400 (EDT)
Subject: [PATCH] drivers/reset: appropriate __init annotation for const
 data
Message-ID: <alpine.LFD.2.20.1507241531370.1806@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Init data marked const should be annotated with __initconst for
correctness and not __initdata.  This also fixes LTO builds that
otherwise fail with section mismatch errors.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index 3d95c87160..9353b2dd15 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -122,7 +122,7 @@ err_alloc:
  * our system, before we can even think of using a regular device
  * driver for it.
  */
-static const struct of_device_id sunxi_early_reset_dt_ids[] __initdata = {
+static const struct of_device_id sunxi_early_reset_dt_ids[] __initconst = {
 	{ .compatible = "allwinner,sun6i-a31-ahb1-reset", },
 	{ /* sentinel */ },
 };
