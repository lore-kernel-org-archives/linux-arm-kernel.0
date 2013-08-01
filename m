From: greg@kroah.com (Greg KH)
Date: Fri, 2 Aug 2013 04:15:39 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801193936.GD23006@n2100.arm.linux.org.uk>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130801193936.GD23006@n2100.arm.linux.org.uk>
Message-ID: <20130801201539.GA12291@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 08:39:36PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 02, 2013 at 03:27:30AM +0800, Greg KH wrote:
> > Hm, sounds like an ACPI tree is what you need to be using :)
> > 
> > Seriously, why not use ACPI for stuff like this?  You already are
> > starting to do that for ARM-based systems, why not just make it the
> > standard?
> 
> Is this in the same spirit as "you should be using DT, DT can describe
> everything you need to do.  It's made to describe bindings between
> devices!" and here we are, two years down the line, and we apparantly
> don't even have stable DT bindings for the ARM architecture because a
> lot of the subsystems which SoCs need have taken that long to get
> sorted.

No, it's in the same spirit of, "others have already done this before,
why are you thinking you need to reinvent the wheel?"

> The amount of work this has taken so far has been tremendous, and we're
> still working out lots of the details.  For instance, in the last six
> months, there's been an effort to try and work out how to sanely
> describe how a DMA controller is connected to a peripheral in DT.

But if people think that DT should only be used for the "platform_bus",
then they need to change their minds.  That's what I am referring to
here.

The platform bus was created for all of those little "we know where this
device is" devices.  Now that DT is being used to dynamically create
devices and their interconnections, it should not be used, as it starts
to fall apart as Will points out.

I'm not saying move away from DT at all, if it can be used to describe
stuff like this, wonderful.  Just please don't use platform_bus anymore
than you have to.

thanks,

greg k-h
