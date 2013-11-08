From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 08 Nov 2013 12:44:01 +0000
Subject: [patch] clk: vexpress: NULL dereference on error path
In-Reply-To: <1383914574.3226.0.camel@hornet>
References: <20131107080844.GR21844@elgon.mountain>
 <1383914574.3226.0.camel@hornet>
Message-ID: <1383914641.3226.1.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-11-08 at 12:42 +0000, Pawel Moll wrote:
> On Thu, 2013-11-07 at 08:08 +0000, Dan Carpenter wrote:
> > If the allocation fails then we dereference the NULL in the error path.
> > Just return directly.
> > 
> > Fixes: ed27ff1db869 ('clk: Versatile Express clock generators ("osc") driver')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> > index 2dc8b41..a535c7b 100644
> > --- a/drivers/clk/versatile/clk-vexpress-osc.c
> > +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> > @@ -102,7 +102,7 @@ void __init vexpress_osc_of_setup(struct device_node *node)
> >  
> >  	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
> >  	if (!osc)
> > -		goto error;
> > +		return;
> >  
> >  	osc->func = vexpress_config_func_get_by_node(node);
> >  	if (!osc->func) {
> 
> Well spotted, thanks!
> 
> Will get it queued with other vexpress clk changes.

Having said that - Mike, it's a bug fix. If you can still get it into
the current merge window, please do:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Pawe?
