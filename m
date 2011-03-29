From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 29 Mar 2011 16:45:09 -0300
Subject: [PATCH 1/2] ARM: mxs/mach-mx28evk: Set the initial value on
	gpio_request_one
Message-ID: <1301427910-31726-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code does not set the GPIO value to zero as mentioned in the comment.

Fix it by setting the initial GPIO value to zero.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

I do not have the hardware to test it, but I fixed it based on the comment.

 arch/arm/mach-mxs/mach-mx28evk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index bb329b9..eacdc6b 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -375,13 +375,13 @@ static void __init mx28evk_init(void)
 	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
 
 	/* power on mmc slot by writing 0 to the gpio */
-	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_DIR_OUT,
+	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc0-slot-power");
 	if (ret)
 		pr_warn("failed to request gpio mmc0-slot-power: %d\n", ret);
 	mx28_add_mxs_mmc(0, &mx28evk_mmc_pdata[0]);
 
-	ret = gpio_request_one(MX28EVK_MMC1_SLOT_POWER, GPIOF_DIR_OUT,
+	ret = gpio_request_one(MX28EVK_MMC1_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc1-slot-power");
 	if (ret)
 		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
-- 
1.6.0.4
