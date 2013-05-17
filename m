From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 17 May 2013 10:15:09 +0000
Subject: [PATCH] ARM: OMAP3+: am33xx id: Add new am33xx specific
 function to check dev_feature
In-Reply-To: <87bo8e1r8o.fsf@linaro.org>
References: <1367996313-6676-1-git-send-email-hvaibhav@ti.com>
 <87bo8e1r8o.fsf@linaro.org>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8BF4F@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at linaro.org]
> Sent: Tuesday, May 14, 2013 3:23 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; tony at atomide.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: OMAP3+: am33xx id: Add new am33xx specific
> function to check dev_feature
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > Layout of DEV_FEATURE register (offset = 0x604) is different
> > between TI81xx and AM33xx device, so create separate function
> > which will check for features available on specific AM33xx SoC
> > and set the flags accordingly.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Minor nit below, otherwise...
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> > ---
> >  arch/arm/mach-omap2/control.h |    5 +++++
> >  arch/arm/mach-omap2/id.c      |   13 +++++++++++++
> >  arch/arm/mach-omap2/io.c      |    2 +-
> >  arch/arm/mach-omap2/soc.h     |    1 +
> >  4 files changed, 20 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-
> omap2/control.h
> > index e6c3281..4acdfc5 100644
> > --- a/arch/arm/mach-omap2/control.h
> > +++ b/arch/arm/mach-omap2/control.h
> > @@ -358,6 +358,11 @@
> >  #define AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH		0x2
> >  #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
> >
> > +/* DEV Feature register to identify AM33XX features */
> > +#define AM33XX_DEV_FEATURE		0x604
> > +#define AM33XX_SGX_SHIFT		29
> 
> You don't need the shift value anywhere in the code, so...
> 
> > +#define AM33XX_SGX_MASK			(1 << AM33XX_SGX_SHIFT)
> 
> #define AM33XX_SGX_MASK		BIT(29)
> 
> instead?
> 
> Otherwise, rest of patch looks fine.
> 
Thanks for the review Kevin.
I just sent out V2 version of the patch with your reviewed-by
With changes you mentioned.

Thanks,
Vaibhav
