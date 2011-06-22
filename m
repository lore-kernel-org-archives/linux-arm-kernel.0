From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 13:35:07 +0200
Subject: [PATCH 2/6] mach-ux500: setting proper uart for snowball
Message-ID: <1308742507-24132-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

The UART setting in uncompress.h changes on the Snowball board.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Robert Marklund <robert.marklund@stericsson.com>
---
 arch/arm/mach-ux500/include/mach/uncompress.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 088b550..7dd0807 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -54,7 +54,8 @@ static inline void arch_decomp_setup(void)
 	if (machine_is_u8500() ||
 	    machine_is_svp8500v1() ||
 	    machine_is_svp8500v2() ||
-	    machine_is_hrefv60())
+	    machine_is_hrefv60()   ||
+	    machine_is_snowball())
 		ux500_uart_base = U8500_UART2_BASE;
 	else if (machine_is_u5500())
 		ux500_uart_base = U5500_UART0_BASE;
-- 
1.7.3.2
