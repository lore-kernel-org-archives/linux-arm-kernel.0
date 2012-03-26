From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Mar 2012 08:39:46 +0000
Subject: Inconsistent kallsyms data on ARM.
In-Reply-To: <20120326074533.GL15647@pengutronix.de>
References: <CAP=VYLoStscdVJretZ-Rkbp7V3Vsm8N0oWcjih7ruHFiDN7CiA@mail.gmail.com>
 <20120326073704.GH5611@n2100.arm.linux.org.uk>
 <20120326074533.GL15647@pengutronix.de>
Message-ID: <201203260839.46858.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 March 2012, Uwe Kleine-K?nig wrote:
> On Mon, Mar 26, 2012 at 08:37:04AM +0100, Russell King - ARM Linux wrote:
> > On Sun, Mar 25, 2012 at 07:59:44PM -0400, Jon Masters wrote:
> > > As to longer term, I am happy to work up something that will spot this
> > > particular kind of failure (symbol changes type) and output something
> > > more useful during the kallsyms generation if you would like.
> > > 
> > > Are you planning to pull in either of the fixes you mention?
> > 
> > I'm not, because those are all sub-optimal - I don't see why we should
> > bloat the kernel image just for the sake of working around kallsyms.
> > 
> > The best I've come up with so far which avoids that is to force
> > KALLSYMS_EXTRA_PASS to always be set on ARM.
> Just to let you know: I even saw failures with KALLSYMS_EXTRA_PASS set.
> Not so in the recent past and sometimes not even reproducible IIRC.
> I will save the build results next time it happens now that I saw what
> to look for.

Yes, I saw these too in my randconfig builds some time ago. Maybe a handful
of builds among 50000 configurations.

	Arnd
