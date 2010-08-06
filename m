From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 06 Aug 2010 13:11:01 -0400 (EDT)
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <AANLkTimw6hbzRRy7gHsvZ_QeJA4MR2Kf4Fvz2roHUX=N@mail.gmail.com>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
	<1278083164.15298.55.camel@ra7055-laptop>
	<20100720211629.GB10553@n2100.arm.linux.org.uk>
	<AANLkTimyif7CCoNwdKMCA=P+y=0e9uhwfhRchbMuB7eY@mail.gmail.com>
	<20100805094521.GB23473@n2100.arm.linux.org.uk>
	<AANLkTimw6hbzRRy7gHsvZ_QeJA4MR2Kf4Fvz2roHUX=N@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1008061308330.28809@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Aug 2010, Eric Miao wrote:

> On Thu, Aug 5, 2010 at 5:45 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Aug 05, 2010 at 04:45:25PM +0800, Eric Miao wrote:
> >> On Wed, Jul 21, 2010 at 5:16 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Fri, Jul 02, 2010 at 10:06:04AM -0500, Rob Herring wrote:
> >> >> Should something more generic like the x86 alternative code be done for
> >> >> ARM? It's very likely we will need patching in other places like for UP
> >> >> and SMP in one kernel.
> >> >
> >> > I think yes, we need to - I can't see how we can sensibly combine
> >> > kernels without this.
> >> >
> >> > However, the effect of this is that XIP can't use this - as the
> >> > kernel text is read-only.
> >> >
> >>
> >> Hi Russell,
> >>
> >> Sorry for late update on this. I've addressed your comments as below,
> >> and really hope this can get into this merge window, so I'm also sending
> >> this to your patch system right now ;-)
> >
> > How does this affect the compiler's instruction scheduling w.r.t. previous
> > load instructions?
> >
> 
> I'm not really sure, so is there some testing benchmarking program
> this can be measured?

I doubt this could be measured with conclusive results.  It would be 
best to simply perform some inspection on the generated assembly, and 
inquire gcc people for the actual scheduling decision in this case.  
That would only be informative as there isn't much we can do on our side 
anyway.


Nicolas
