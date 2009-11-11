From: mcuos.com@gmail.com (Wan ZongShun)
Date: Wed, 11 Nov 2009 22:35:22 +0800
Subject: [PATCH] ARM: fix bug of checking on signed return value using unsigned
	statement in w90p910 platform
Message-ID: <4AFACBAA.1030503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear sir,

To fix the bug of checking on signed return value using unsigned statement.
Thanks Roel Kluin for digging out it. 

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 drivers/net/arm/w90p910_ether.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/arm/w90p910_ether.c b/drivers/net/arm/w90p910_ether.c
index 25e2627..b7f3866 100644
--- a/drivers/net/arm/w90p910_ether.c
+++ b/drivers/net/arm/w90p910_ether.c
@@ -160,8 +160,8 @@ struct  w90p910_ether {
 	struct mii_if_info mii;
 	struct timer_list check_timer;
 	void __iomem *reg;
-	unsigned int rxirq;
-	unsigned int txirq;
+	int rxirq;
+	int txirq;
 	unsigned int cur_tx;
 	unsigned int cur_rx;
 	unsigned int finish_tx;
-- 
1.5.6.3
