From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 1 Sep 2010 13:12:20 +0200
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100901100155.GN8142@n2100.arm.linux.org.uk>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901100155.GN8142@n2100.arm.linux.org.uk>
Message-ID: <20100901111220.GD22790@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +static __inline__ struct clk_lookup_alloc *arch_kzalloc(size_t size)
> 
> No need to use __inline__ here - use inline instead.
> 
> > +static __inline__ struct clk_lookup_alloc *arch_kzalloc(size_t size)
> 
> Ditto.
> 
> > @@ -120,12 +124,12 @@ struct clk_lookup_alloc {
> >  	char	con_id[MAX_CON_ID];
> >  };
> >  
> > -struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
> > -	const char *dev_fmt, ...)
> > +struct clk_lookup * __init_refok
> > +clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
> 
> This looks like a nasty hack to get around the problem of calling a
> boot-time only allocator - but I guess given what sh is doing we don't
> have much choice here.
> 
> The choice of 'arch_kzalloc' is imho very poor - it potentially could
> clash with some other use.  Maybe __clkdev_alloc() instead?
ok I'll update

Best Regards,
J.
