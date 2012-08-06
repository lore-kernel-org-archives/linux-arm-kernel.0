From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Aug 2012 16:35:35 +0200
Subject: [PATCH] ARM: imx35: don't disable the uart clock when DEBUG_LL
 is in use
In-Reply-To: <20120806142406.GC9329@pengutronix.de>
References: <1343742279-29570-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120731174358.GC30009@pengutronix.de>
 <20120731183206.GC10670@pengutronix.de>
 <20120806142406.GC9329@pengutronix.de>
Message-ID: <20120806143535.GC1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 04:24:06PM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Jul 31, 2012 at 08:32:06PM +0200, Uwe Kleine-K?nig wrote:
> > Hello Sascha,
> > 
> > On Tue, Jul 31, 2012 at 07:43:58PM +0200, Sascha Hauer wrote:
> > > On Tue, Jul 31, 2012 at 03:44:39PM +0200, Uwe Kleine-K?nig wrote:
> > > > Otherwise printch et al. and printk with earlyprintk and keep_bootcon
> > > > becomes unfunctional when the clk framework disables all unused clocks.
> > > 
> > > Why don't you use the regular console? Letting the clock framework
> > > disable the clocks was pretty much intentional.
> > I don't question that disabling unused clocks is sensible. But usually
> > if you enable DEBUG_LL you want to use it even after the clock framework
> > disabled all (apparently) unused clocks. And in my case the regular
> > console didn't work yet and so I relied on earlyprintk.
> > Even if the problem proved to be the result of my stupidity this patch
> > asserts that earlyprintk just works as it should be for debug aids.
> ping

Honestly, I don't think this is a good idea. You fixed one UART on one
SoC, so ARRAY_SIZE(i.MX1, i.MX21, i.MX25, i.MX27, i.MX31, i.MX35,
i.MX51, i.MX53, i.MX6) * NUM_UARTS remain broken for this usecase. IMO
DEBUG_LL is to get some stuff out of an otherwise silent board, nothing
more.

Sascha



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
