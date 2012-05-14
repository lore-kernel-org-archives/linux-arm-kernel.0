From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 14 May 2012 10:53:48 +0200
Subject: [PATCH 3/5] ARM: imx: add audio codec clk lookup for imx53-qsb
In-Reply-To: <20120514085002.GE20367@S2100-06.ap.freescale.net>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-4-git-send-email-shawn.guo@linaro.org>
 <20120514082201.GF21318@pengutronix.de>
 <20120514085002.GE20367@S2100-06.ap.freescale.net>
Message-ID: <20120514085348.GB30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 04:50:03PM +0800, Shawn Guo wrote:
> On Mon, May 14, 2012 at 10:22:01AM +0200, Sascha Hauer wrote:
> > >  static void __init imx53_dt_init(void)
> > >  {
> > >  	struct device_node *node;
> > > @@ -99,6 +115,9 @@ static void __init imx53_dt_init(void)
> > >  		of_node_put(node);
> > >  	}
> > >  
> > > +	if (of_machine_is_compatible("fsl,imx53-qsb"))
> > > +		imx53_qsb_init();
> > > +
> > 
> > I wonder if we really want to open this can of worms here. Adding board
> > specific hacks (or fixups) in this file can become very messy once we
> > have more than only a few oftree based boards.
> > 
> From what I have seen, this is an acceptable solution to board specific
> setup.  What's the alternative on your mind?

Right now I do not have an alternative, I just try to see 2 years in the
future. Maybe until then we can do it this way and then I'll point to
this post saying 'I told you' ;)

I hope we won't get to that point. The above should be really in the
devicetree, right?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
