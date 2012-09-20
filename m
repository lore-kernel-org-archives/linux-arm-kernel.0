From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:39 +0200
Subject: [PATCH 21/32] ARM: ux500: Remove platform registration of MSP devices
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-22-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes platform device registration of all 4 MSP
devices. It also takes care of all redundant infrastructure now
that each of the ux500 audio components have been Device Tree
enabled.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index ddc74c5..d04f54d 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -174,16 +174,6 @@ struct msp_i2s_platform_data msp3_platform_data = {
 /* Due for removal once the MSP driver has been fully DT:ed. */
 void mop500_of_msp_init(struct device *parent)
 {
-	pr_info("Initialize MSP I2S-devices.\n");
-	db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
-			   &msp0_platform_data);
-	db8500_add_msp_i2s(parent, 1, U8500_MSP1_BASE, IRQ_DB8500_MSP1,
-			   &msp1_platform_data);
-	db8500_add_msp_i2s(parent, 2, U8500_MSP2_BASE, IRQ_DB8500_MSP2,
-			   &msp2_platform_data);
-	db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
-			   &msp3_platform_data);
-
 	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
 	platform_device_register(&ux500_pcm);
 }
-- 
1.7.9.5
