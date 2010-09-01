From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 1 Sep 2010 13:18:46 +0200
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100901095121.GA11107@pengutronix.de>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901095121.GA11107@pengutronix.de>
Message-ID: <20100901111846.GF22790@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  
> > -struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
> > -	const char *dev_fmt, ...)
> > +struct clk_lookup * __init_refok
> Why do you need __init_refok?  __init_refok is defined as follows in
> include/linux/init.h:
> 
> 	/* compatibility defines */
> 	#define __init_refok     __ref
> 
> So if really needed better use __ref.  Couldn't this be __init?  
ok for __ref but __init_refok is more clear IMHO
and yes we need it as for early device we may use bootmem as slab allocators
may no be availlable in some case

Best Regards,
J.
