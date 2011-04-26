From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 26 Apr 2011 09:54:37 +0800
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <20110425185113.GF14770@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110424134833.GC2310@richard-laptop>
	<20110425185113.GF14770@pengutronix.de>
Message-ID: <20110426015435.GA4600@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 08:51:13PM +0200, Sascha Hauer wrote:
> On Sun, Apr 24, 2011 at 09:48:33PM +0800, Richard Zhao wrote:
> > > +
> > > +	div = clk_divider_bestdiv(clk, rate, &best_parent_rate);
> > > +
> > > +	if (rate != best_parent_rate / div)
> > > +		return -EINVAL;
> > > +
> > > +	ret = clk_set_rate(divider->parent, best_parent_rate);
> > why do you set parent rate? It may impact hte parent's other children.
> >
> 
> In a newer version I already created a barrier flag for not setting the
> parents rate. Setting the parents rate is needed for for example
> cascaded dividers. Otherwise this could be much simpler.
And do you find a way to let clock actual parents indepent on reset or uboot
register settings. If we can register clk, maybe:
if (clk->ops.hw_get_parent)
	clk->parent = clk->ops->hw_get_parent;

Thanks
Richard
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
