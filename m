From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 21 Nov 2015 20:56:21 -0500 (EST)
Subject: [PATCH] drivers/reset: appropriate __init annotation for const
 data
Message-ID: <alpine.LFD.2.20.1511212053530.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Init data marked const should be annotated with __initconst for
correctness and not __initdata.  This also fixes LTO builds that
otherwise fail with section mismatch errors.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
