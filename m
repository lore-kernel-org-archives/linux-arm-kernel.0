From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Jan 2011 00:18:23 +0530
Subject: [PATCH 4/5] omap2plus: voltage: Trivial linking fix 'undefined
	reference'
In-Reply-To: <4D236AFB.2050301@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com>
	<4D236AFB.2050301@ti.com>
Message-ID: <2a7055e7c506648a2a48a0454756687b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Wednesday, January 05, 2011 12:16 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; tony at atomide.com;
> linux-arm-kernel at lists.infradead.org; Thara Gopinath; Kevin Hilman
> Subject: Re: [PATCH 4/5] omap2plus: voltage: Trivial linking fix
> 'undefined reference'
>
> Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the
> following:
> [..]
>
> > diff --git a/arch/arm/plat-omap/include/plat/voltage.h
> b/arch/arm/plat-omap/include/plat/voltage.h
> > index 710f4ea..c095351 100644
> > --- a/arch/arm/plat-omap/include/plat/voltage.h
> > +++ b/arch/arm/plat-omap/include/plat/voltage.h
> > @@ -65,9 +65,6 @@ struct voltagedomain {
> >  	char *name;
> >  };
> >
> > -/* API to get the voltagedomain pointer */
> > -struct voltagedomain *omap_voltage_domain_lookup(char *name);
> > -
> >  /**
> >   * struct omap_volt_data - Omap voltage specific data.
> >   * @voltage_nominal:	The possible voltage value in uV
> > @@ -131,6 +128,9 @@ int omap_voltage_register_pmic(struct
> voltagedomain *voltdm,
> >  		struct omap_volt_pmic_info *pmic_info);
> >  void omap_change_voltscale_method(struct voltagedomain *voltdm,
> >  		int voltscale_method);
> > +/* API to get the voltagedomain pointer */
> > +struct voltagedomain *omap_voltage_domain_lookup(char *name);
> > +
> >  int omap_voltage_late_init(void);
> >  #else
> >  static inline int omap_voltage_register_pmic(struct voltagedomain
> *voltdm,
> > @@ -144,6 +144,10 @@ static inline int
> omap_voltage_late_init(void)
> >  {
> >  	return -EINVAL;
> >  }
> > +static inline struct voltagedomain
> *omap_voltage_domain_lookup(char *name)
> > +{
> > +	return NULL;
> the omap_voltage_domain_lookup uses ERR_PTR() for all return values
> which are handled by the callers with IS_ERR()
>
> I think you should return ERR_PTR(-EINVAL)
>
The expected return value is pointer type and hence used
NULL.
