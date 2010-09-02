From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 2 Sep 2010 04:37:12 +0200
Subject: [RFC] [PATCH] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100901231752.GA25860@n2100.arm.linux.org.uk>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<20100901091233.GK8142@n2100.arm.linux.org.uk>
	<20100901111302.GE22790@game.jcrosoft.org>
	<20100901231752.GA25860@n2100.arm.linux.org.uk>
Message-ID: <20100902023712.GH22790@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:17 Thu 02 Sep     , Russell King - ARM Linux wrote:
> On Wed, Sep 01, 2010 at 01:13:02PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 10:12 Wed 01 Sep     , Russell King - ARM Linux wrote:
> > > On Tue, Aug 31, 2010 at 01:16:42PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > factorise some generic infrastructure to assist looking up struct clks
> > > > for the ARM & SH architecture.
> > > > +/*
> > > > + * Returns a clock. Note that we first try to use device id on the bus
> > > > + * and clock name. If this fails, we try to use clock name only.
> > > > + */
> > > >  struct clk *clk_get(struct device *dev, const char *con_id)
> > > >  {
> > > >  	const char *dev_id = dev ? dev_name(dev) : NULL;
> > > >  
> > > >  	return clk_get_sys(dev_id, con_id);
> > > >  }
> > > > -EXPORT_SYMBOL(clk_get);
> > > > +EXPORT_SYMBOL_GPL(clk_get);
> > > >  
> > > >  void clk_put(struct clk *clk)
> > > >  {
> > > >  	__clk_put(clk);
> > > >  }
> > > > -EXPORT_SYMBOL(clk_put);
> > > > +EXPORT_SYMBOL_GPL(clk_put);
> > > 
> > > Please leave these as-is.
> > ok but on SH it's GPL so it is ok with you Paul too?
> 
> If you want to get that pedantic... I created clkdev, and Sascha Hauer
> extended it with some refactoring to create the clk_get_sys() interface.
personnaly It's fine for I
I just get in mind to knon if Paul have a specific reason to put it as GPL
EXPORT_SYMBOL

Best Regards,
J.
