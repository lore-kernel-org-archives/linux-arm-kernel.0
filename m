From: b32955@freescale.com (Huang Shijie)
Date: Mon, 26 May 2014 14:47:46 +0800
Subject: [PATCH 1/2] ARM: clk: imx: add a new helper which can
 re-parent the clock
In-Reply-To: <20140526080120.GE2650@dragon>
References: <1401081633-12190-1-git-send-email-b32955@freescale.com>
 <20140526080120.GE2650@dragon>
Message-ID: <20140526064745.GA31472@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 04:01:21PM +0800, Shawn Guo wrote:
> On Mon, May 26, 2014 at 01:20:32PM +0800, Huang Shijie wrote:
> > The clocks for Quadspi controller may be different when different
> > NOR flashes are connected to the board.
> > 
> > This patch adds a new helper to register the clock which needs the
> > re-parent capability.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> 
> So what you need is to register a mux clock without
> CLK_SET_RATE_NO_REPARENT flag, right?
yes.

Without this fixed flag, I can pass the CLK_SET_RATE_PARENT in the "flags".


> 
> I'm think about just dropping the flag from imx_clk_mux() and
> imx_clk_mux_flags(), since this is the default behavior of basic mux
> clock, and I doubt dropping the flag will cause problem for mux clocks
> on i.MX.
this is what i was worry about.

So i do not change the imx_clk_mux/imx_clk_mux_flags, and add new helper which
has the minimum impact to the current code.

thanks
Huang Shijie
