From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 16:44:31 +0200
Subject: [PATCH] ARM: imx: clk-vf610: introduce clks_init_on
In-Reply-To: <1406643628-4061-1-git-send-email-stefan@agner.ch>
References: <1406643628-4061-1-git-send-email-stefan@agner.ch>
Message-ID: <2815679.ZycfkLhBgI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 16:20:28 Stefan Agner wrote:
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
> 

Wouldn't it be better to list this in the DT as a default for
the respective clocks?

	Arnd
