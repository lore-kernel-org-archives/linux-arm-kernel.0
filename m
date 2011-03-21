From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 21 Mar 2011 16:15:45 +0100
Subject: [PATCH] ARM: mxs: TX28: Add support for first Flexcan port on STK5-V3
	base board and second Flexcan port on STK5-V4
In-Reply-To: <1300720545-14123-3-git-send-email-LW@KARO-electronics.de>
References: <1300720545-14123-1-git-send-email-LW@KARO-electronics.de>
	<1300720545-14123-2-git-send-email-LW@KARO-electronics.de>
	<1300720545-14123-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <1300720545-14123-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-mxs/mach-tx28.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index f7c6526..fa00848 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -363,6 +363,7 @@ static void __init tx28_stk5v3_init(void)
 	mx28_add_mxs_i2c(0);
 	i2c_register_board_info(0, tx28_stk5v3_i2c_boardinfo,
 			ARRAY_SIZE(tx28_stk5v3_i2c_boardinfo));
+	mx28_add_flexcan(0, NULL);
 	tx28_init_fb();
 	mx28_add_mxs_mmc(0, &tx28_mmc0_pdata);
 }
@@ -388,6 +389,7 @@ static void __init tx28_stk5v4_init(void)
 	i2c_register_board_info(0, tx28_stk5v3_i2c_boardinfo,
 			ARRAY_SIZE(tx28_stk5v3_i2c_boardinfo));
 	mx28_add_flexcan(0, NULL);
+	mx28_add_flexcan(1, NULL);
 	tx28_init_fb();
 	mx28_add_mxs_mmc(0, &tx28_mmc0_pdata);
 }
-- 
1.5.6.5
