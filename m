From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Mar 2011 22:52:34 -0300
Subject: [PATCH 4/4] ARM: mx5/mx53_evk: Make the reset pin name more meaningful
In-Reply-To: <1300326754-4629-3-git-send-email-festevam@gmail.com>
References: <1300326754-4629-1-git-send-email-festevam@gmail.com>
	<1300326754-4629-2-git-send-email-festevam@gmail.com>
	<1300326754-4629-3-git-send-email-festevam@gmail.com>
Message-ID: <1300326754-4629-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there is a mx53_smd board in the kernel, using SMD_FEC_PHY_RST as the pin name can be misleading when used 
on a MX53_EVK board.

Change the pin name to reflect the board name.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
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
