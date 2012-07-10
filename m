From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 10 Jul 2012 09:10:44 +0000
Subject: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
In-Reply-To: <20120710084107.GO1122@atomide.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
 <20120627133950.GJ3483@atomide.com> <20120627161745.GO3483@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA5C2C4@DBDE01.ent.ti.com>
 <20120710084107.GO1122@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA69AA3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 14:11:08, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120627 13:37]:
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -42,7 +42,14 @@
> >  #define OMAP2_DEVICE_TYPE_GP           3
> >  #define OMAP2_DEVICE_TYPE_BAD          4
> > 
> > +#ifdef CONFIG_ARCH_OMAP2PLUS
> >  int omap_type(void);
> > +#else
> > +inline static int omap_type(void)
> > +{
> > +	/* Always return GP, since it is not being used anyway for omap1 */
> > +	return OMAP2_DEVICE_TYPE_GP;
> > +}
> > +#endif
> > 
> >  /*
> >   * omap_rev bits:
> 
> Just to follow-up on this, looks like we need to postpone this
> for v3.7. While at it, we need to make sure all soc_is_omapxxxx()
> are false by default.
> 

Just FYI, I had submitted V2 of this patch.

> What you're suggesting above would also depend on some MULTI_ARCH
> option set if multiple ARM architectures are selected. Above patch
> would only optimize things when ARCH_OMAP2PLUS alone is selected.
> 

Isn't this only applicable for ARCH_OMAP2PLUS and OMAP1?? And above patch 
take cares of both, as OMAP1 and 2 will not be build together, since 
compiler flags itself will be different.

Can you elaborate on how things will break if multiple ARM architectures are 
selected?

I am not sure whether I am following you completely.

Thanks,
Vaibhav
