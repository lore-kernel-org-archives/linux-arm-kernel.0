From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 09:10:28 +0800
Subject: [PATCH V2 13/14] i2c: imx: add clk_prepare/clk_unprepare
In-Reply-To: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
References: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320973829-4388-14-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/i2c/busses/i2c-imx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 58832e5..8d1ab6f 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -196,7 +196,7 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
-	clk_enable(i2c_imx->clk);
+	clk_prepare_enable(i2c_imx->clk);
 	writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
 	/* Enable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
@@ -245,7 +245,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 
 	/* Disable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
-	clk_disable(i2c_imx->clk);
+	clk_disable_unprepare(i2c_imx->clk);
 }
 
 static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
-- 
1.7.5.4
