From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 27 Sep 2009 08:08:07 +0100
Subject: [PATCH v2 4/5] Add suspend/resume support for rx1950
In-Reply-To: <200909271001.20642.anarsoul@gmail.com>
References: <4abe82e7.0405560a.5ebe.4296@mx.google.com>
	<20090927061951.GM31920@trinity.fluff.org>
	<200909271001.20642.anarsoul@gmail.com>
Message-ID: <20090927070807.GN31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 10:01:08AM +0300, Vasily Khoruzhick wrote:
> ?? ?????????????????? ???? 27 ???????????????? 2009 09:19:51 ?????????? Ben Dooks ??????????????:
> > >  		__raw_writel(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
> > > +		if (machine_is_rx1950()) {
> > > +			/* According to S3C2442 user's manual, page 7-17,
> > > +			 * when the system is operating in NAND boot mode,
> > > +			 * the hardware pin configuration - EINT[23:21] ???
> > > +			 * must be set as input for starting up after
> > > +			 * wakeup from sleep mode */
> > 
> > given this is generic to the s3c2442, why put this here? it also holds
> > for the s3c2440 too... think about an implementation for the cpu's
> > sysdev for all nand-booting systems.
> 
> Well, actually I thought that suspend for h1940 and rx3000 works without these 
> tricks... Ok, I'll make it generic for s3c2442 CPU.

The h1940 is a s3c2410 and all the boot pins on it are specific function
for boot. No idea if the rx3xxx series use the upper EINT lines for
anything.

Anyway, please include the s3c2440 in this change as I belive it
also has the saem note.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
