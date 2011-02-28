From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Feb 2011 10:13:51 +0000
Subject: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operation
	can cause data corruption
In-Reply-To: <20110227120021.GA15314@n2100.arm.linux.org.uk>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
	<1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
	<20110227120021.GA15314@n2100.arm.linux.org.uk>
Message-ID: <20110228101351.GA30781@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 27, 2011 at 12:00:21PM +0000, Russell King - ARM Linux wrote:
> > +#else
> > +/* Optimised out for non-errata case */
> > +static inline void debug_writel(unsigned long val)
> > +{
> >  }
> 
> #define l2x0_set_debug	NULL
> 
> > +#endif

I notice you got rid of the inline function.  Have you tried building this
without the errata enabled?
