From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 30 Mar 2015 13:30:40 +0300
Subject: [patch] spi: pxa2xx: missing break in pxa2xx_ssp_get_clk_div()
Message-ID: <20150330103040.GB27144@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We refactored this code but accidentally left out a break statement so
QUARK_X1000_SSP isn't handled correctly.

Fixes: 025ffe88ee60 ('spi: pxa2xx: shift clk_div in one place')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 60526a5..a081cfc 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -791,6 +791,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		clk_div = quark_x1000_get_clk_div(rate, &chip->dds_rate);
+		break;
 	default:
 		clk_div = ssp_get_clk_div(drv_data, rate);
 	}
