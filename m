From: juergen.lambrecht@gmail.com (=?UTF-8?q?J=C3=BCrgen=20Lambrecht?=)
Date: Tue,  5 Jul 2011 15:35:31 +0200
Subject: [PATCH] Enable RTC driver.
Message-ID: <1309872931-13999-1-git-send-email-J.Lambrecht@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MC13783 MFD also contains an RTC. Enable it.
To avoid "No RTC device found, ALARM timers will not wake from suspend",
this patch is needed:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c008ba58af24dc5d0d8e9fe6e59d876910254761

Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>
---
 arch/arm/mach-imx/mach-mx27_3ds.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 84114aa..00bbb6b 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -294,7 +294,8 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 		.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
 
 	},
-	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
+	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN |
+	MC13783_USE_RTC,
 };
 
 /* SPI */
-- 
1.7.1
