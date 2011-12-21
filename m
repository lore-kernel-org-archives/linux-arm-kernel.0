From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Dec 2011 10:07:06 +0000
Subject: Is Pandaboard cpuhotplug working stably?
In-Reply-To: <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
 <20111221094624.GB3354@n2100.arm.linux.org.uk>
 <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
Message-ID: <20111221100706.GC3354@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 05:59:07PM +0800, Barry Song wrote:
> 2011/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > cpu hotplug is basically totally buggered - the preconditions placed
> > upon the bringup code path are basically impossible to satisfy in any
> > shape or form at the moment.
> >
> > There's the requirement that the secondary CPU is marked online and
> > active before interrupts are enabled for the thread migration stuff
> > to behave correctly. ?However, this is incompatible with smp_call_function()
> > which will wait for online CPUs to respond to an IPI - which this one
> > won't because interrupts are disabled.
> >
> > I think there was some discussion about how to fix this but I don't
> > recall the details.
> 
> thanks, Russell. then could i think this is an ARM-kernel-specific bug
> which exists on all ARM SMP chips for the moment?
> and that bug doesn't happen on x86:

I don't think so.  There's nothing ARM specific about it.
