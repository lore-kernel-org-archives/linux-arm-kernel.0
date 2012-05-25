From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 25 May 2012 10:41:08 +0800
Subject: [PATCH 2/5] ARM: imx6q: add clock for apbh-dma
In-Reply-To: <4FBEE96D.7010509@freescale.com>
References: <1337856659-24812-1-git-send-email-b32955@freescale.com>
 <1337856659-24812-2-git-send-email-b32955@freescale.com>
 <20120524173028.GD16535@pengutronix.de>
 <4FBEE96D.7010509@freescale.com>
Message-ID: <20120525024105.GD3332@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 10:07:41AM +0800, Huang Shijie wrote:
> ? 2012?05?25? 01:30, Sascha Hauer ??:
> >On Thu, May 24, 2012 at 06:50:56PM +0800, Huang Shijie wrote:
> >>add the clock for apbh-dma.
> >>
> >>Signed-off-by: Huang Shijie<b32955@freescale.com>
> >>---
> >>  arch/arm/mach-imx/clk-imx6q.c |    3 ++-
> >>  1 files changed, 2 insertions(+), 1 deletions(-)
> >>
> >>diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> >>index cab02d0..12d9040 100644
> >>--- a/arch/arm/mach-imx/clk-imx6q.c
> >>+++ b/arch/arm/mach-imx/clk-imx6q.c
> >>@@ -318,7 +318,7 @@ int __init mx6q_clocks_init(void)
> >>  	clk[ahb]               = imx_clk_busy_divider("ahb",               "periph",      base + 0x14, 10,  3,   base + 0x48, 1);
> >>
> >>  	/*                                name             parent_name          reg         shift */
> >>-	clk[apbh_dma]     = imx_clk_gate2("apbh_dma",      "ahb",               base + 0x68, 4);
> >>+	clk[apbh_dma]     = imx_clk_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);
> >This change looks strange. Is this correct?
> yes. it's correct.
> 
> The datasheet about the clock tells us the parent of the apbh-dma is usdhc3.
> 
I guess it's a hardware bug.

-- 
Regards,
Shawn
