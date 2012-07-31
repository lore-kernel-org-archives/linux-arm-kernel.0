From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 14:39:05 +0100
Subject: [PATCH 11/19] ARM: ux500: Stop registering the PCM driver from
 platform code
In-Reply-To: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343741953-17828-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now initialise the PCM driver through the MSP DAI, so there is
no need to register it though platform code anymore. This patch
strips out all PCM platform registration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 71d62ed..7af2dce 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -184,9 +184,6 @@ void mop500_of_msp_init(struct device *parent)
 			   &msp2_platform_data);
 	db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
 			   &msp3_platform_data);
-
-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
-	platform_device_register(&ux500_pcm);
 }
 
 void mop500_msp_init(struct device *parent)
@@ -203,7 +200,4 @@ void mop500_msp_init(struct device *parent)
 			   &msp2_platform_data);
 	db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
 			   &msp3_platform_data);
-
-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
-	platform_device_register(&ux500_pcm);
 }
-- 
1.7.9.5
