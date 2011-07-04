From: zonque@gmail.com (Daniel Mack)
Date: Mon, 4 Jul 2011 12:20:08 +0200
Subject: [RFC PATCH 0/3] base board consolidation
In-Reply-To: <20110704082722.GM21898@n2100.arm.linux.org.uk>
References: <20110701094403.GT11559@pengutronix.de>
	<20110704082722.GM21898@n2100.arm.linux.org.uk>
Message-ID: <CACTFLAPsaiF8KEXeDGOX72dcAvzegHDUQcPEPNxywwYewrHsUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2011 at 10:27 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 01, 2011 at 11:44:03AM +0200, Uwe Kleine-K?nig wrote:
>> At some time this will probably be obsoleted by device tree stuff, the
>> upside of this approach is that it already works today without the need
>> to adapt the bootloader.
>
> The other issue is that the reverse is also true - platforms can be a
> common baseboard, and its the CPU tile which changes. ?That's standard
> for the ARM development boards.
>
> While the CPU tiles for platforms before Versatile Express had very
> little variance other than the actual CPU, Versatile Express can have
> dramatically different physical address maps depending on the CPU tile
> fitted. ?The only real common thing is the offsets for peripherals
> within each chip select region.
>
> As also said, all this should be solved by DT, so I don't see there's
> much point in creating this abstraction just to have it obsoleted
> shortly thereafter. ?Much better to put that effort into ensuring that
> DT can handle these setups...
>

Yes, I would also much more like to see these boards being supported
by DT, and eventually, we can probably provide static tree definitions
for these boards and get rid of the whole code entirely.


Daniel
