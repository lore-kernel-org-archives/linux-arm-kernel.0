From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 25 Apr 2011 20:51:13 +0200
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <20110424134833.GC2310@richard-laptop>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110424134833.GC2310@richard-laptop>
Message-ID: <20110425185113.GF14770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 24, 2011 at 09:48:33PM +0800, Richard Zhao wrote:
> > +
> > +	div = clk_divider_bestdiv(clk, rate, &best_parent_rate);
> > +
> > +	if (rate != best_parent_rate / div)
> > +		return -EINVAL;
> > +
> > +	ret = clk_set_rate(divider->parent, best_parent_rate);
> why do you set parent rate? It may impact hte parent's other children.
>

In a newer version I already created a barrier flag for not setting the
parents rate. Setting the parents rate is needed for for example
cascaded dividers. Otherwise this could be much simpler.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
