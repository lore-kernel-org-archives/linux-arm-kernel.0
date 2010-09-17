From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 17 Sep 2010 15:53:52 +0530
Subject: [PATCH 11/14] omap4: Fix silicon version detection for early
	samples
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C014F13A77F@dlee02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-11-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C014F13A77F@dlee02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307C8E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Friday, September 17, 2010 3:48 PM
> To: Shilimkar, Santosh; linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 11/14] omap4: Fix silicon version detection for early
> samples
> 
> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> > Sent: Friday, September 17, 2010 4:48 AM
> 
> [..]
> 
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index ae70ae9..0412233 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -308,6 +308,15 @@ static void __init omap4_check_revision(void)
> >  	hawkeye = (idcode >> 12) & 0xffff;
> >  	rev = (idcode >> 28) & 0xff;
> >
> > +	/*
> > +	 * Few initial ES2.0 samples IDCODE is same as ES1.0
> > +	 * Use ARM register to detect the correct ES version
> > +	 */
> > +	if (!rev) {
> > +		idcode = read_cpuid(CPUID_ID);
> > +		rev = (idcode & 0xf) - 1;
> > +	}
> > +
> 
> Squash this to patch 10?
> 
Actually this was kind of temporary patch and was suppose to be
reverted later and hence I kept it separate. 
Felipe, benoit suggested to have this change anyways considering
it's just one check.
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg34521.html

But now I think we can fold this into id patch itself. Will fold it
into patch 10.

Regards,
Santosh
