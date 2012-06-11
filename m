From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jun 2012 15:11:05 -0400 (EDT)
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <20120611184148.GD18267@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <20120611182640.GC18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111430300.23555@xanadu.home>
 <20120611184148.GD18267@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1206111458310.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012, Russell King - ARM Linux wrote:

> On Mon, Jun 11, 2012 at 02:40:24PM -0400, Nicolas Pitre wrote:
> > On Mon, 11 Jun 2012, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Jun 11, 2012 at 01:18:28PM -0400, Nicolas Pitre wrote:
> > > > And that message certainly has to go as it may be triggered multiple 
> > > > times per second in some use cases here.
> > > 
> > > That, I interpret, as an attempt to use CPU hotplugging for power
> > > saving.
> > > 
> > > No.  Do not do that.  Under any circumstances.  Not only is the CPU
> > > hotplugging code racy in places, it also totally destroys the ability
> > > to have threads bound to CPUs, or even interrupts to CPUs.
> > 
> > [ more comments ommitted ]
> > 
> > Russell, let me suggest you take the time to read this:
> > 
> > 	http://lwn.net/Articles/481055/
> > 
> > then let's restart this conversation if you please.
> 
> Same comments apply for exactly the reasons I stated.

No they don't.  They can't. The generic kernel code doesn't know what is 
happening behind the scene and may not even care if at the low level a 
complete CPU replacement happened.  Trust me, I happen to know one thing 
or two about those issues you mentioned and the code I'm working on will 
be posted in due course.

But that is not the point of this thread.  The point I want to bring 
forward is:

- IPIs are needed to wake up remote CPUs

- we should formalize a number for it and the actual number is the least 
  of my concern

- the warning must go

- and we shouldn't wait until the entire world comes forth to confirm 
  any arbitrary SGI number works for them or nothing will ever happen.

Can we make some progress with this please?


Nicolas
