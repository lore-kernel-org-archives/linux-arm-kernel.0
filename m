From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 17 Mar 2011 12:55:59 -0300
Subject: [PATCH v2 4/4] ARM: mx5/mx53_evk: Make the reset pin name more
	meaningful
In-Reply-To: <1300377359-23212-3-git-send-email-fabio.estevam@freescale.com>
References: <1300377359-23212-1-git-send-email-fabio.estevam@freescale.com>
	<1300377359-23212-2-git-send-email-fabio.estevam@freescale.com>
	<1300377359-23212-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1300377359-23212-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there is a mx53_smd board in the kernel, using SMD_FEC_PHY_RST as the pin name can be misleading when used 
on a MX53_EVK board.

Change the pin name to reflect the board name.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx53_evk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index d771999..2af3f43 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -34,7 +34,7 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
 
-#define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+#define MX53_EVK_FEC_PHY_RST	IMX_GPIO_NR(7, 6)
 #define EVK_ECSPI1_CS0		IMX_GPIO_NR(2, 30)
 #define EVK_ECSPI1_CS1		IMX_GPIO_NR(3, 19)
 
@@ -82,14 +82,14 @@ static inline void mx53_evk_fec_reset(void)
 	int ret;
 
 	/* reset FEC PHY */
-	ret = gpio_request_one(SMD_FEC_PHY_RST, GPIOF_OUT_INIT_LOW,
+	ret = gpio_request_one(MX53_EVK_FEC_PHY_RST, GPIOF_OUT_INIT_LOW,
 							"fec-phy-reset");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
 		return;
 	}
 	msleep(1);
-	gpio_set_value(SMD_FEC_PHY_RST, 1);
+	gpio_set_value(MX53_EVK_FEC_PHY_RST, 1);
 }
 
 static struct fec_platform_data mx53_evk_fec_pdata = {
-- 
1.6.0.4
