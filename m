From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Wed, 3 Oct 2018 14:12:11 +0200
Subject: [PATCH] spi: pxa2xx: Mark expected switch fall-through
Message-ID: <20181003121211.GA28108@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1056539 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fc9aac2..728b5f3 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -666,6 +666,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 			switch (drv_data->n_bytes) {
 			case 4:
 				bytes_left >>= 1;
+				/* Fall through */
 			case 2:
 				bytes_left >>= 1;
 			}
-- 
2.7.4
