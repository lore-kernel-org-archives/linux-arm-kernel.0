From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Sep 2012 09:31:30 +0200
Subject: [PATCH] ARM:IMX6Q:use pll2_pfd2_396m as the enfc_sel's parent
In-Reply-To: <20120919053348.GH6460@S2100-06.ap.freescale.net>
References: <1347261476-9799-1-git-send-email-b32955@freescale.com>
 <20120919053348.GH6460@S2100-06.ap.freescale.net>
Message-ID: <20120919073130.GX6180@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 01:33:50PM +0800, Shawn Guo wrote:
> On Mon, Sep 10, 2012 at 03:17:56PM +0800, Huang Shijie wrote:
> > The gpmi-nand driver can support the ONFI nand chip's EDO (extra data out)
> > mode in the asynchrounous mode. In the asynchrounous mode 5, the gpmi
> > needs 100MHz clock for the IO. But with the pll2_pfd0_352m, we can not
> > get the 100MHz clock.
> > 
> > So choose pll2_pfd2_396m as enfc_sel's parent.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> 
> Applied, thanks.
> 
> But we really expect that clock framework can get improved to have such
> case handled in clk_set_rate() call.

How do you want to archieve that? It would be possible to teach the
clock framework to iterate over the possible parents and see what gives
the best result, but how do we teach the clock framework that there are
other constraints, like for example 'use this clock in low power mode
and that one otherwise'?

We have a similar problem with the IPU: When the LDB is used, the IPU
pixel clock has to be switched to the LDB clock, even if other clocks
would result in a more accurate frequency.

That's a topic for a long long discussion, I think even longer than it
took to introduce the clock framework ;)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
