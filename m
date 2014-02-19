From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Feb 2014 19:09:10 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
In-Reply-To: <1391080640-23370-1-git-send-email-tomi.valkeinen@ti.com>
References: <1391080640-23370-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <alpine.DEB.2.02.1402191908520.8777@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Jan 2014, Tomi Valkeinen wrote:

> If CLK_SET_RATE_PARENT is set for a clkoutx2 clock, calling
> clk_set_rate() on the clock "skips" the x2 multiplier as there are no
> set_rate and round_rate functions defined for the clkoutx2.
> 
> This results in getting double the requested clock rates, breaking the
> display on omap3430 based devices. This got broken when
> d0f58bd3bba3877fb1af4664c4e33273d36f00e4 and related patches were merged
> for v3.14, as omapdss driver now relies more on the clk-framework and
> CLK_SET_RATE_PARENT.
> 
> This patch implements set_rate and round_rate for clkoutx2.
> 
> Tested on OMAP3430, OMAP3630, OMAP4460.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued for v3.14-rc with Tero's ack.


- Paul
