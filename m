From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 23:31:46 +0100
Subject: [RFC PATCH] smp: parallel smp boot option
In-Reply-To: <1277158949.17092.61.camel@c-dwalke-linux.qualcomm.com>
References: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
	<20100621220030.GC13624@n2100.arm.linux.org.uk>
	<1277158949.17092.61.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100621223146.GE13624@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 03:22:29PM -0700, Daniel Walker wrote:
> On Mon, 2010-06-21 at 23:00 +0100, Russell King - ARM Linux wrote:
> > On Mon, Jun 21, 2010 at 02:40:22PM -0700, Daniel Walker wrote:
> > > +#ifdef CONFIG_SMP_PARALLEL_START
> > > +	bl	__smp_secondary_spin
> > > +#endif
> > 
> 
> Your OK with this hook? I was thinking it might be better to check if
> it's the book cpu or the secondary here instead of in
> arch/arm/mach-msm .

Not entirely.  It would appear that it means you can never used a
compressed kernel on MSM, since if you do, you'll have all CPUs in
the system decompressing the kernel simultaneously.

If we have to have this hook, how about making it a weak reference
rather than something dealt with by the configuration system?
