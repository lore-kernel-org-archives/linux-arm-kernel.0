From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 6 Aug 2012 16:24:06 +0200
Subject: [PATCH] ARM: imx35: don't disable the uart clock when DEBUG_LL
 is in use
In-Reply-To: <20120731183206.GC10670@pengutronix.de>
References: <1343742279-29570-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120731174358.GC30009@pengutronix.de>
 <20120731183206.GC10670@pengutronix.de>
Message-ID: <20120806142406.GC9329@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 08:32:06PM +0200, Uwe Kleine-K?nig wrote:
> Hello Sascha,
> 
> On Tue, Jul 31, 2012 at 07:43:58PM +0200, Sascha Hauer wrote:
> > On Tue, Jul 31, 2012 at 03:44:39PM +0200, Uwe Kleine-K?nig wrote:
> > > Otherwise printch et al. and printk with earlyprintk and keep_bootcon
> > > becomes unfunctional when the clk framework disables all unused clocks.
> > 
> > Why don't you use the regular console? Letting the clock framework
> > disable the clocks was pretty much intentional.
> I don't question that disabling unused clocks is sensible. But usually
> if you enable DEBUG_LL you want to use it even after the clock framework
> disabled all (apparently) unused clocks. And in my case the regular
> console didn't work yet and so I relied on earlyprintk.
> Even if the problem proved to be the result of my stupidity this patch
> asserts that earlyprintk just works as it should be for debug aids.
ping

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
