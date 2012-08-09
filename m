From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:47:27 +0100
Subject: [PATCH 01/22] ARM: ux500: Fix merge error,
 no matching driver name for 'snd_soc_u8500'
In-Reply-To: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527268-5964-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform attempts to register platform device 'snd_soc_u8500'
which doesn't actually exist. Here we change the reference to the
correct one 'snd_soc_mop500'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 9960480..df15646 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -191,9 +191,9 @@ static struct platform_device *db8500_add_msp_i2s(struct device *parent,
 	return pdev;
 }
 
-/* Platform device for ASoC U8500 machine */
-static struct platform_device snd_soc_u8500 = {
-		.name = "snd-soc-u8500",
+/* Platform device for ASoC MOP500 machine */
+static struct platform_device snd_soc_mop500 = {
+		.name = "snd-soc-mop500",
 		.id = 0,
 		.dev = {
 			.platform_data = NULL,
@@ -227,8 +227,8 @@ int mop500_msp_init(struct device *parent)
 {
 	struct platform_device *msp1;
 
-	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
-	platform_device_register(&snd_soc_u8500);
+	pr_info("%s: Register platform-device 'snd-soc-mop500'.\n", __func__);
+	platform_device_register(&snd_soc_mop500);
 
 	pr_info("Initialize MSP I2S-devices.\n");
 	db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
-- 
1.7.9.5
