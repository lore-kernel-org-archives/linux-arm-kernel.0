From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Aug 2013 16:28:08 -0700
Subject: [PATCH 2/3] ARM: vexpress: make spc code TC2-only
In-Reply-To: <20130805095532.GC29090@e102568-lin.cambridge.arm.com>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <1375675793-16492-3-git-send-email-olof@lixom.net>
 <20130805095532.GC29090@e102568-lin.cambridge.arm.com>
Message-ID: <20130805232808.GB32172@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 10:55:32AM +0100, Lorenzo Pieralisi wrote:
> On Mon, Aug 05, 2013 at 05:09:52AM +0100, Olof Johansson wrote:
> > It doesn't make sense to match this to the generic compatible value,
> > since the code is quite specific to TC2 as it is.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  arch/arm/mach-vexpress/spc.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> > index 34e4bf4..30cfa9f 100644
> > --- a/arch/arm/mach-vexpress/spc.c
> > +++ b/arch/arm/mach-vexpress/spc.c
> > @@ -187,18 +187,14 @@ void ve_spc_powerdown(u32 cluster, bool enable)
> >  	writel_relaxed(enable, info->baseaddr + pwdrn_reg);
> >  }
> >  
> > -static const struct of_device_id ve_spc_ids[] __initconst = {
> > -	{ .compatible = "arm,vexpress-spc,v2p-ca15_a7" },
> > -	{ .compatible = "arm,vexpress-spc" },
> > -	{},
> > -};
> > -
> >  static int __init ve_spc_probe(void)
> >  {
> >  	int ret;
> > -	struct device_node *node = of_find_matching_node(NULL, ve_spc_ids);
> > +	struct device_node *dn;
> > +
> > +	dn = of_find_compatible_node(NULL, "arm,vexpress-spc,v2p-ca15_a7");
> 
> Missing a parameter, should be:
> 
> of_find_compatible_node(NULL, NULL, "arm,vexpress-spc,v2p-ca15_a7");

My bad, thinking vexpress_defconfig enabled this so I didn't make sure I had
build coverage.

> If my changes to the bindings are acceptable we must match the new string.

Done.


-Olof
