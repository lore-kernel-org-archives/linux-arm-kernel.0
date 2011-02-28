From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 28 Feb 2011 18:17:07 +0530
Subject: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operationcan
	cause data corruption
In-Reply-To: <20110228101351.GA30781@n2100.arm.linux.org.uk>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
	<1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
	<20110227120021.GA15314@n2100.arm.linux.org.uk>
	<20110228101351.GA30781@n2100.arm.linux.org.uk>
Message-ID: <69dd173e3c7b4d02ef50ceaa19b2343a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, February 28, 2011 3:44 PM
> To: Santosh Shilimkar
> Cc: tony at atomide.com; catalin.marinas at arm.com; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way
> operationcan cause data corruption
>
> On Sun, Feb 27, 2011 at 12:00:21PM +0000, Russell King - ARM Linux
> wrote:
> > > +#else
> > > +/* Optimised out for non-errata case */
> > > +static inline void debug_writel(unsigned long val)
> > > +{
> > >  }
> >
> > #define l2x0_set_debug	NULL
> >
> > > +#endif
>
> I notice you got rid of the inline function.  Have you tried
> building this without the errata enabled?

I accidently dropped the inline function while
incorporating the comment from you. :(

Fixed it. Updated version # 6770/1

Regards,
Santosh
