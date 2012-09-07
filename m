From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:48 +0100
Subject: [PATCH 08/19] ARM: ux500: Stop registering Audio devices for HREF
 when DT is enabled
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1347016499-29354-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index a42418b..0219c276 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -840,8 +840,6 @@ static void __init u8500_init_machine(void)
 		platform_add_devices(mop500_platform_devs,
 				ARRAY_SIZE(mop500_platform_devs));
 
-		mop500_audio_init(parent);
-
 		i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 		i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
 
-- 
1.7.9.5
