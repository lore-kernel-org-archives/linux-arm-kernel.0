From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Aug 2013 17:09:32 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130802142010.GC7533@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802115334.GN2465@mudshark.cambridge.arm.com>
 <20130802142010.GC7533@kroah.com>
Message-ID: <20130802160932.GG5292@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 03:20:10PM +0100, Greg KH wrote:
> On Fri, Aug 02, 2013 at 12:53:34PM +0100, Will Deacon wrote:
> > We can change the mindset by yelling, but if you're writing a new
> > driver for a peripheral on an ARM SoC, platform_bus is mighty tempting
> > because you get a bunch of device-tree parsing code for free (see
> > drivers/of/platform.c).
> 
> I know :(
> 
> So, who do I "yell at", and what do I do to make things easier for you
> from the driver-core perspective?

I would anticipate most of these drivers going through the arm-soc tree, so
Olof and Kevin would be doing the yelling. You could join in the chorus too!

We basically need reviewers to adopt the position that a new bus should be
considered and dismissed before using the platform_bus, then you can yell
transitively through them.

> > Agreed, it's time that we started to describe these non-probable buses as
> > separate bus_types, with controller logic for configuring the bus itself
> > (there are weird-and-wonderful ring-based designs on the horizon which can
> > require a fair amount of setup).
> 
> I've heard rumors of those for a while now, I'll believe it when I see
> them :)

Oh, they're coming. I'm trying to understand the programmer's model for one
as we speak :) On the plus side, you also get a whole bunch of debug and PMU
data on these things, which is interesting from a kernel perspective.

> > So, like a good proportion of the ARM community, ACPI isn't something I'm
> > well-versed in. Yes, it's coming, but at the same time it's not going to be
> > everywhere and we need to continue to support new SoCs using device-tree.
> > Whilst it might even become a de-factor standard for servers, mobile devices
> > will likely continue with the bootloaders they currently have. Furthermore,
> > the mobile space is really the wild-west when it comes to system topology --
> > exynos SoCs tend to have one IOMMU per device, for example:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/181922.html
> > 
> > On the back of that, how does ACPI describe these relationships? It would
> > certainly be a good idea to see what's already being done so we don't
> > reinvent everything again for device-tree.
> 
> I don't recall the specifics of how it does this, but the spec is open
> (and bad to read, sorry), and the linux-acpi mailing list is very
> welcoming, so I suggest you start there if you have questions.

Understandable, I'll make an effort to RTFM, although I don't think that
mitigates the need for discussion in this area.

Cheers,

Will
