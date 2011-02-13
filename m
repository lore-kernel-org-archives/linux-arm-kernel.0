From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Feb 2011 10:43:47 +0000
Subject: [PATCH RFC] ARM: MPCore v6_early_abort enhancement
In-Reply-To: <20110211225342.GD236@mvista.com>
References: <20110211215421.GA29361@mvista.com>
	<20110211223844.GB31356@n2100.arm.linux.org.uk>
	<20110211225342.GD236@mvista.com>
Message-ID: <20110213104347.GA6138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 05:53:42PM -0500, George G. Davis wrote:
> Hi,
> 
> On Fri, Feb 11, 2011 at 10:38:44PM +0000, Russell King - ARM Linux wrote:
> > On Sat, Feb 12, 2011 at 12:54:21AM +0300, Valentine Barshak wrote:
> > > SWP instruction sets bit 11 in DFSR, in case of data fault on SMP MPCore.
> > > So v6_early_abort doesn't need erratum 326103 workaround for MPCore.
> > 
> > NAK.  When building a SMP kernel which also supports v6 CPUs, this will
> > cause v6 CPUs to break.
> 
> Since the SWP erratum only affects ARM1136 (UP) processors, how will this
> break ARM11 MPCore (v6) processors?

Omitting the code will break MPcore processors.

> Are you referring to unified kernels which support both UP and SMP machines?

Of course.

> I reckon that's a recent feature to be able to boot SMP kernels on UP
> machines.

Makes no difference if it's a recent feature or not.  We're not adding
new obstacles to this when we're getting rid of them.  It's counter
productive.

> Perhaps if that's why you're against this, then we need to have a
> separate config option to specifically enable this ARM1136 erratum
> workaround?

No we don't.  Omitting the code is an optimization to what is already a
slow path which results in breakage for people.  That's why I nak'd it.
