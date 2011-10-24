From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 24 Oct 2011 17:02:09 -0200
Subject: [PATCH] ARM: mx31pdk: Add MC13783 RTC support
Message-ID: <1319482929-28262-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX31PDK board has a MC13783 PMIC, which provides RTC functionality.

Add support for it.

While at it, also use the generic MC13XXX flags.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx31_3ds.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index c20be75..e82778c 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -494,7 +494,8 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 		.regulators = mx31_3ds_regulators,
 		.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
 	},
-	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
+	.flags  = MC13XXX_USE_REGULATOR | MC13XXX_USE_TOUCHSCREEN |
+							MC13XXX_USE_RTC,
 };
 
 /* SPI */
-- 
1.6.0.4
