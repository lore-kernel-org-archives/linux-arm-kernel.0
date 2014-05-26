From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 May 2014 16:11:59 +0800
Subject: [PATCH 1/2] ARM: clk: imx: add a new helper which can re-parent
 the clock
In-Reply-To: <20140526064745.GA31472@shlinux1.ap.freescale.net>
References: <1401081633-12190-1-git-send-email-b32955@freescale.com>
 <20140526080120.GE2650@dragon>
 <20140526064745.GA31472@shlinux1.ap.freescale.net>
Message-ID: <20140526081158.GF2650@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 02:47:46PM +0800, Huang Shijie wrote:
> > I'm think about just dropping the flag from imx_clk_mux() and
> > imx_clk_mux_flags(), since this is the default behavior of basic mux
> > clock, and I doubt dropping the flag will cause problem for mux clocks
> > on i.MX.
> this is what i was worry about.
> 
> So i do not change the imx_clk_mux/imx_clk_mux_flags, and add new helper which
> has the minimum impact to the current code.

Can you just try to drop the flag from imx_clk_mux/imx_clk_mux_flags
calls, and see if it causes any immediate problem for us?  If not, we
may want to create a patch for that, and throw it into linux-next for
wider testing.

Shawn
