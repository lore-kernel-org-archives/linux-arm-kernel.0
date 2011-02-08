From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 8 Feb 2011 09:47:54 +0530
Subject: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support for
	all DPLL's
In-Reply-To: <alpine.DEB.2.00.1102072037530.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-7-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1102071952300.21991@utopia.booyaka.com>
	<1eea151edf0ed021258c202c6d9b5bc2@mail.gmail.com>
	<alpine.DEB.2.00.1102072037530.21991@utopia.booyaka.com>
Message-ID: <972f3f2e6c362ecdd1f00b412e79ad5d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Tuesday, February 08, 2011 9:11 AM
> To: Rajendra Nayak
> Cc: Santosh Shilimkar; linux-omap at vger.kernel.org; Kevin Hilman; Benoit
Cousson; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [PATCH v2 6/9] omap: dpll: Add allow_idle/deny_idle support
for all DPLL's
>
> On Tue, 8 Feb 2011, Rajendra Nayak wrote:
>
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul at pwsan.com]
> > > Sent: Tuesday, February 08, 2011 8:27 AM
> > >
> > > >  arch/arm/mach-omap2/clock.c          |    8 +++++++-
> > > >  arch/arm/mach-omap2/clock.h          |    1 +
> > > >  arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
> > > >  arch/arm/mach-omap2/clock44xx_data.c |    2 +-
> > > >  arch/arm/mach-omap2/pm44xx.c         |    4 ++++
> > >
> > > Looks like you add the allow_idle/deny_idle functions for the OMAP3
CORE
> > > DPLL, but you don't change mach-omap2/pm34xx.c.  Any reason for
this?
> >
> > Nothing specifically. My initial patchset was enabling these only for
> > OMAP4, So I thought will keep it that way.
>
> That's fine with me, but you might want to drop the OMAP3 part of the
> changes, or put them into a separate patch.

Ok, will add a separate patch for OMAP3 and remove the register
writes from mach-omap2/pm34xx.c.

>
> Also, when you resend the autoidle patches, could you put them into a
> separate series?  There's an autoidle series that I've been working on
> here, and I will add those into that series, and keep the other patch
> series separate.

Ok, will repost these patches as a separate series.

Regards,
Rajendra

>
>
> thanks,
>
> - Paul
