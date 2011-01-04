From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Jan 2011 00:20:02 +0530
Subject: [PATCH 4/5] omap2plus: voltage: Trivial linking fix 'undefined
	reference'
In-Reply-To: <2a7055e7c506648a2a48a0454756687b@mail.gmail.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com>
	<4D236AFB.2050301@ti.com>
	<2a7055e7c506648a2a48a0454756687b@mail.gmail.com>
Message-ID: <d7800f7a785b294a089ea8772607d232@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Wednesday, January 05, 2011 12:18 AM
> To: Nishanth Menon
> Cc: linux-omap at vger.kernel.org; Kevin Hilman; tony at atomide.com;
> linux-arm-kernel at lists.infradead.org; Thara Gopinath; Kevin Hilman
> Subject: RE: [PATCH 4/5] omap2plus: voltage: Trivial linking fix
> 'undefined reference'
>
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > owner at vger.kernel.org] On Behalf Of Nishanth Menon
> > Sent: Wednesday, January 05, 2011 12:16 AM
> > To: Santosh Shilimkar
> > Cc: linux-omap at vger.kernel.org; khilman at ti.com; tony at atomide.com;
> > linux-arm-kernel at lists.infradead.org; Thara Gopinath; Kevin Hilman
> > Subject: Re: [PATCH 4/5] omap2plus: voltage: Trivial linking fix
> > 'undefined reference'
> >
> > Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the
> > following:
> > [..]
> >
[..]

> > > +static inline struct voltagedomain
> > *omap_voltage_domain_lookup(char *name)
> > > +{
> > > +	return NULL;
> > the omap_voltage_domain_lookup uses ERR_PTR() for all return
> values
> > which are handled by the callers with IS_ERR()
> >
> > I think you should return ERR_PTR(-EINVAL)
> >
> The expected return value is pointer type and hence used
> NULL.

'ERR_PTR(-EINVAL)' is also ok.
