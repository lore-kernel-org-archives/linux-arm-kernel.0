From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Wed, 21 Jul 2010 12:10:38 +0530
Subject: Your patch: ARM: AMBA: Add pclk definition for platforms using
	primecells
In-Reply-To: <0D753D10438DA54287A00B02708426976374051D65@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B02708426976374051D65@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100721064036.GA17884@bnru02.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 01:54:18 +0200, H Hartley Sweeten wrote:
> Hello Russell,
> 
> Your patch added a new clock to the ep93xx platform called "apb_pclk".

Unrelated to ep93xx, but the same patch breaks the u8500 build:

arch/arm/mach-ux500/clock.c:459: error: 'clk_dummy_apb_pclk' undeclared here (not in a function)

The following can be folded in to fix it:

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index e618ab1..d8ab7f1 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -453,7 +453,7 @@ static DEFINE_PRCC_CLK_CUSTOM(7, mtu0_ed, 2, -1, NULL, clk_mtu_get_rate, 0);
 static DEFINE_PRCC_CLK(7, wdg_ed, 	1, -1, NULL);
 static DEFINE_PRCC_CLK(7, cfgreg_ed, 	0, -1, NULL);
 
-static struct clk dummy_apb_pclk;
+static struct clk clk_dummy_apb_pclk;
 
 static struct clk_lookup u8500_common_clks[] = {
 	CLK(dummy_apb_pclk, NULL,	"apb_pclk"),
