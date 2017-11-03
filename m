From: broonie@kernel.org (Mark Brown)
Date: Fri, 3 Nov 2017 18:37:00 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <1509731639.5473.60.camel@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
Message-ID: <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 05:53:59PM +0000, Trent Piepho wrote:

> Just to be clear, one doesn't need to use GPIOs with the driver as is. 
> But the bindings to do that are non-standard and these patches make the
> driver follow the standard. (and don't break anyone).

If there are non-standard bindings then mark them as deprecated.  I
can't immediately find *any* binding documentation for this controller.
The last commit looks like it was more attempting to work round broken
board bindings and do something sensible than add a new binding, at
least that's what I remember my sense of it being.

> It's unfortunate that this, and in my experience every, SPI master
> doesn't always (or ever) generate the waveforms it should according to
> the Linux API.  But I don't think not following the specification for
> the device tree bindings is a mitigation of this.  If anything, it just
> creates more problems.

If the hardware is as broken as these controllers always were in the
past and there are workarounds which work in all practical situations
(AFAIK all the relevant SoCs permit GPIO usage on the chip select pins)
documenting something as supported is just going to make people
miserable.  The reason I know about this breakage is that I had to go
through the process of working out that the native chip select support
didn't work on a system.

> If the goal is to document the hardware quirks, then shouldn't this be
> done through documentation?  A note or pointer in the kconfig,
> something in the source, a better description in Documention/
> somewhere, etc.  That would have a better chance of being seen before
> hardware is designed, and would explain the issue too, instead of just
> appearing as another quirk in device tree bindings.

Yes, better documentation would be great.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171103/bcafb781/attachment.sig>
