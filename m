From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 21 Nov 2011 16:26:51 -0200
Subject: [PATCH v2] ARM: mx31pdk: Add MC13783 RTC support
Message-ID: <1321900012-8351-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX31PDK board has a MC13783 PMIC, which provides RTC functionality.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:

- Rebased on top of 3.2-rc2

 arch/arm/mach-imx/mach-mx31_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index b8c54b8..00bb308 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -492,7 +492,7 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 		.regulators = mx31_3ds_regulators,
 		.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
 	},
-	.flags  = MC13XXX_USE_TOUCHSCREEN,
+	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC,
 };
 
 /* SPI */
-- 
1.7.1
