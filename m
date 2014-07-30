From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 30 Jul 2014 10:44:46 +0800
Subject: [PATCH] ARM: imx: clk-vf610: introduce clks_init_on
In-Reply-To: <1406643628-4061-1-git-send-email-stefan@agner.ch>
References: <1406643628-4061-1-git-send-email-stefan@agner.ch>
Message-ID: <20140730024445.GB10206@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 04:20:28PM +0200, Stefan Agner wrote:
> At the end of the boot process, the clock framework might disable
> required main PLL's. So far, this was no issue since drivers
> requested clocks, which are descended of the main PLL's (e.g.
> pll1_pfd1, which provides the system clock).
> 
> To archive the full 500MHz system clock, DDR clock need to be a
> descendant of PLL2 rather than PLL1 (DDRC_CLK_SEL set to 0). The
> bootloader sets up the clocks accordingly before making use of
> DDR at all. However, in Linux, there is no driver using PLL2,
> which lead to PLL2 being disabled by the clock framework.
> 
> With this patch, we make sure that the main system clock and the
> DDR clock are initially enabled and are kept enabled.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
