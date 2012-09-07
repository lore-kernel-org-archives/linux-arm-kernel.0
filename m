From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:45 +0100
Subject: [PATCH 05/19] ARM: ux500: Stop registering HREF's SDI devices from
 platform data
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1347016499-29354-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HREF Device Tree now has support for its four SDIs. So, if we
continue registering them from platform code when Device Tree is
enabled we'll cause a double probe of the same devices. To prevent
that we'll just remove registration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 9575150..a42418b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -840,7 +840,6 @@ static void __init u8500_init_machine(void)
 		platform_add_devices(mop500_platform_devs,
 				ARRAY_SIZE(mop500_platform_devs));
 
-		hrefv60_sdi_init(parent);
 		mop500_audio_init(parent);
 
 		i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
-- 
1.7.9.5
