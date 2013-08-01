From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 20:39:36 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801192730.GC9174@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
Message-ID: <20130801193936.GD23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 03:27:30AM +0800, Greg KH wrote:
> Hm, sounds like an ACPI tree is what you need to be using :)
> 
> Seriously, why not use ACPI for stuff like this?  You already are
> starting to do that for ARM-based systems, why not just make it the
> standard?

Is this in the same spirit as "you should be using DT, DT can describe
everything you need to do.  It's made to describe bindings between
devices!" and here we are, two years down the line, and we apparantly
don't even have stable DT bindings for the ARM architecture because a
lot of the subsystems which SoCs need have taken that long to get
sorted.

The amount of work this has taken so far has been tremendous, and we're
still working out lots of the details.  For instance, in the last six
months, there's been an effort to try and work out how to sanely
describe how a DMA controller is connected to a peripheral in DT.

Maybe some of those experiences can be applied to ACPI - I doubt that
ACPI has the ability to describe everything that we need to with ARM
SoCs, just like DT was missing a whole bunch of established ways to
describe ARM SoCs when we started looking at it.

One advantage we will have though is having gone through the DT pain,
we're now that much more experienced with describing stuff in firmware,
so hopefully we can avoid some of the DT mistakes with ACPI.
