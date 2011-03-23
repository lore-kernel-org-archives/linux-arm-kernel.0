From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 23 Mar 2011 11:03:50 +0100
Subject: [PATCH 1/6] mach-netx: delete hardcoded periphid
Message-ID: <1300874630-14708-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The periphid of the AMBA CLCD controller is hardcoded to a value
that the CLCD driver does not even support.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-netx/fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
index 5b84bcd..b991323 100644
--- a/arch/arm/mach-netx/fb.c
+++ b/arch/arm/mach-netx/fb.c
@@ -103,7 +103,6 @@ static struct amba_device fb_device = {
 		.flags	= IORESOURCE_MEM,
 	},
 	.irq		= { NETX_IRQ_LCD, NO_IRQ },
-	.periphid	= 0x10112400,
 };
 
 int netx_fb_init(struct clcd_board *board, struct clcd_panel *panel)
-- 
1.7.3.2
