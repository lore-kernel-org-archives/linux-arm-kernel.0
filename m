From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 13 Jul 2011 11:39:59 +0800
Subject: [PATCH V2 08/10] ARM: mxs: add mxs-sgtl5000 device
In-Reply-To: <1310483085-31442-1-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
Message-ID: <1310528399-25109-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/mach-mx28evk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index c8b154a..03f75fe 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -425,6 +425,9 @@ static void __init mx28evk_init(void)
 	i2c_register_board_info(0, mxs_i2c0_board_info,
 				ARRAY_SIZE(mxs_i2c0_board_info));
 
+	mxs_add_platform_device("mxs-sgtl5000", 0, NULL, 0,
+			NULL, 0);
+
 	/*set the saif clk mux, both saif0/saif1 use saif0 clk*/
 	__raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);
 
-- 
1.7.0.4
