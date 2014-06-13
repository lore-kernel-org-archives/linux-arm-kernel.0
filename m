From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 13 Jun 2014 09:17:20 -0400
Subject: [PATCH V2 16/19] irqchip: crossbar: introduce
 ti,max-crossbar-sources to identify valid crossbar mapping
In-Reply-To: <539AD87C.8000004@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-17-git-send-email-r.sricharan@ti.com>
 <20140612135453.GB8664@titan.lakedaemon.net>
 <539AD87C.8000004@ti.com>
Message-ID: <20140613131720.GI8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 04:24:52PM +0530, Sricharan R wrote:
> On Thursday 12 June 2014 07:24 PM, Jason Cooper wrote:
> > On Thu, Jun 12, 2014 at 05:23:24PM +0530, Sricharan R wrote:
...
> >> +	of_property_read_u32(node, "ti,max-crossbar-sources",
> >> +			     &cb->max_crossbar_sources);
> >> +	if (!cb->max_crossbar_sources) {
> >> +		pr_err("missing 'ti,max-crossbar-sources' property\n");
> >> +		ret = -EINVAL;
> >> +		goto err_base;
> >> +	}
> > 
> > This completely breaks all boards using old dtbs.  Please set
> > max_crossbar_sources to a sane value (400) when the property is missing.
> > 
> >> +
> >>  	of_property_read_u32(node, "ti,max-irqs", &max);
> >>  	if (!max) {
> >>  		pr_err("missing 'ti,max-irqs' property\n");
> > 
> > I know this is context, but you may want to look at this property as
> > well and set it to a sane value instead of erroring out.
> > 
>  crossbar dts node itself is not there in any dts yet. So this is not applicable
>  for any old boards. Any future dts with crossbar node should have this property
>  defined.

Now that I see the dra7.dtsi changes, I fully agree.

thx,

Jason.
