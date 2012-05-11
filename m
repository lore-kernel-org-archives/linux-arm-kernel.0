From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 11 May 2012 05:30:23 +0000
Subject: [PATCH-V2 4/4] ARM: OMAP2+: CLEANUP: Add new config option for
 different DPLL features
In-Reply-To: <alpine.DEB.2.00.1205101634350.32719@utopia.booyaka.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
 <1336506724-5494-5-git-send-email-hvaibhav@ti.com> <87ehqui8yp.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA1BF47@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205101634350.32719@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA21FED@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 04:05:56, Paul Walmsley wrote:
> On Wed, 9 May 2012, Hiremath, Vaibhav wrote:
> 
> > On Wed, May 09, 2012 at 04:20:06, Hilman, Kevin wrote:
> > 
> > > 
> > > [1]
> > > diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
> > > index d0ef57c..656b986 100644
> > > --- a/arch/arm/plat-omap/include/plat/clock.h
> > > +++ b/arch/arm/plat-omap/include/plat/clock.h
> > > @@ -156,7 +156,6 @@ struct dpll_data {
> > >  	u8			min_divider;
> > >  	u16			max_divider;
> > >  	u8			modes;
> > > -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> > >  	void __iomem		*autoidle_reg;
> > >  	void __iomem		*idlest_reg;
> > >  	u32			autoidle_mask;
> > > @@ -167,7 +166,6 @@ struct dpll_data {
> > >  	u8			auto_recal_bit;
> > >  	u8			recal_en_bit;
> > >  	u8			recal_st_bit;
> > > -#  endif
> > >  	u8			flags;
> > >  };
> > >  
> > 
> > Honestly, I wanted to propose this first. 
> > I am OK, as long as we all agree on this.
> > 
> > Paul, can you conform on this?
> 
> Yes that's a better approach then defining CONFIG_* options for all the 
> bitfields, so please go ahead and just send a patch to drop that #ifdef 
> and I'll ack it.
> 
> 

Thanks Paul,

I will submit it shortly.

Thanks,
Vaibhav
