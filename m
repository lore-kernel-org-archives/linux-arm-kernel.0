From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 01 Aug 2013 14:48:50 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801203631.GA12802@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130801193936.GD23006@n2100.arm.linux.org.uk>
 <20130801201539.GA12291@kroah.com>
 <20130801201823.GF23006@n2100.arm.linux.org.uk>
 <20130801203631.GA12802@kroah.com>
Message-ID: <1375393730.2070.16.camel@dabdike>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-02 at 04:36 +0800, Greg KH wrote:
> On Thu, Aug 01, 2013 at 09:18:23PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Aug 02, 2013 at 04:15:39AM +0800, Greg KH wrote:
> > > I'm not saying move away from DT at all, if it can be used to describe
> > > stuff like this, wonderful.  Just please don't use platform_bus anymore
> > > than you have to.
> > 
> > As far as that sentiment goes, it would have been nice if that was made
> > more vocally ten years ago, because at that time I was the one trying to
> > encourage people to think about creating appropriate bus types, and what
> > I was being told was that no, bus types are something which are deprecated
> > and platform bus is what should be used.
> 
> Was that me that said that?  I don't recall it at all, and if I did, I
> was flat out wrong.  I've always said that platform_bus is a hack, and
> should only be used as a "last resort".  Others have grabbed onto it as
> the "only" way to do devices for embedded things because that is what
> they were used to.

I don't think so.

If you recall ancient history, the reason the generic device DMA model
was created was because on parisc the PCI bus isn't the root of the
device tree and we needed some way to express that properly so the
IOMMUs got programmed correctly.  After dma stuff was added to the
generic device, we pushed all the parisc stuff under a platform specific
parisc bus type.  My understanding of platform_bus was that it's always
been for stuff you couldn't probe properly or classify properly.  I can
see why people would think unprobable SoCs should live on platform_bus,
but no-one ever came to us in parisc and told us to stop using our own
internal bus type.

James
