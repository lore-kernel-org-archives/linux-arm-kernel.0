From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2012 13:45:58 +0100
Subject: [PATCH 14/18] ARM: ux500: Stop registering the PCM driver from
 platform code
In-Reply-To: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343393162-11938-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this patch we prevent PCM driver registration from platform
code and rely solely on Device Tree to do the probing for us.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 1a83fa5..391c129 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -186,9 +186,6 @@ void mop500_of_msp_init(struct device *parent)
 			   &msp2_platform_data);
 	db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
 			   &msp3_platform_data);
-
-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
-	platform_device_register(&ux500_pcm);
 }
 
 void mop500_msp_init(struct device *parent)
-- 
1.7.9.5
