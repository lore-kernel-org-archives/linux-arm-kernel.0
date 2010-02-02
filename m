From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:13 -0800
Subject: [PATCH 01/16] ARM: LPC32XX: clock lookups array should not be tagged
	__initdata
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-2-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

struct clk looksup[] should not be tagged with the __initdata
attribute so system functions after bootup can use the clkdev
support.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 615c091..d404b67 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -959,7 +959,7 @@ EXPORT_SYMBOL(clk_get_parent);
 		.clk = &(c), \
 	},
 
-static struct clk_lookup lookups[] __initdata = {
+static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "osc_32KHz", osc_32KHz)
 	_REGISTER_CLOCK(NULL, "osc_pll397", osc_pll397)
 	_REGISTER_CLOCK(NULL, "osc_main", osc_main)
-- 
1.6.6
