From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 19 Jul 2011 12:36:20 +0800
Subject: [PATCH v4 08/10] ARM: mxs: add mxs-sgtl5000 device
In-Reply-To: <1310731780-1645-9-git-send-email-b29396@freescale.com>
References: <1310731780-1645-9-git-send-email-b29396@freescale.com>
Message-ID: <1311050180-22355-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Just resend for rebase [PATCH v4 06/10] ARM: mxs: add saif device
---
 arch/arm/mach-mxs/mach-mx28evk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index fe5ea41..521c4d5 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -424,6 +424,9 @@ static void __init mx28evk_init(void)
 	i2c_register_board_info(0, mxs_i2c0_board_info,
 				ARRAY_SIZE(mxs_i2c0_board_info));
 
+	mxs_add_platform_device("mxs-sgtl5000", 0, NULL, 0,
+			NULL, 0);
+
 	/* power on mmc slot by writing 0 to the gpio */
 	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc0-slot-power");
-- 
1.7.0.4
