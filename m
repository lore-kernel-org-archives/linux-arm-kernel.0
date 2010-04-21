From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 21 Apr 2010 17:24:51 -0400 (EDT)
Subject: kernel virtual memory access (from app) does not generatesegfault
In-Reply-To: <20100421193534.GC26616@n2100.arm.linux.org.uk>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100420223106.GQ11723@shareable.org>
	<20100420224108.GA1432@n2100.arm.linux.org.uk>
	<000001cae144$4281a9a0$4044010a@Emea.Arm.com>
	<20100421193534.GC26616@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1004211723230.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Apr 2010, Russell King - ARM Linux wrote:

> On Wed, Apr 21, 2010 at 12:17:41PM +0100, Dave P. Martin wrote:
> >  
> > 
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
> > > Sent: 20 April 2010 23:41
> > > To: Jamie Lokier
> > > Cc: Ben Dooks; anfei; Dave P Martin; 
> > > linux-arm-kernel at lists.infradead.org
> > > Subject: Re: kernel virtual memory access (from app) does not 
> > > generatesegfault
> > 
> > [...]
> > 
> > > The difference between instruction faults and data faults is 
> > > that we always interpret instruction faults on pre-ARMv6 CPUs 
> > > as a 'translation fault' rather than a permission fault since 
> > > they can't tell us what the problem was.
> > 
> > Note that my observations were on an armv7 kernel.  Should we still hit the
> > same bit of code in this case, or have I misdiagnosed the problem?
> 
> If it was ARMv7, we should be reading the IFSR, which should be telling
> us that there's a permission fault trying to read instructions from
> 0xc0000000.
> 
> If changing do_translation_fault() on a recent kernel fixes your problem,
> something's going wrong.  Any chance you could add some debugging to
> do_PrefetchAbort() so that when you see your test program running
> (eg, if (strcmp(current->comm, "progname") == 0) { ... }) you could
> dump out the values of ifsr and addr please?

If I remember right, the original bug report mentioned ARM926.


Nicolas
