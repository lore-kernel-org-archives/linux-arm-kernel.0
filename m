From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 07 Jan 2014 12:29:47 +0100
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <52CB6719.6040604@boundarydevices.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
 <1388767737.19394.32.camel@pizza.hi.pengutronix.de>
 <20140103170724.GT7383@n2100.arm.linux.org.uk>
 <1388770004.19394.42.camel@pizza.hi.pengutronix.de>
 <52C70C1A.3090108@boundarydevices.com>
 <1389030088.5590.30.camel@pizza.hi.pengutronix.de>
 <20140106174606.GG27432@n2100.arm.linux.org.uk>
 <52CB6719.6040604@boundarydevices.com>
Message-ID: <1389094187.4815.24.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 06.01.2014, 19:31 -0700 schrieb Eric Nelson:
> Hi Russell,
> 
> On 01/06/2014 10:46 AM, Russell King - ARM Linux wrote:
> > On Mon, Jan 06, 2014 at 06:41:28PM +0100, Philipp Zabel wrote:
> >> Hi Eric,
> >>
> >> Am Freitag, den 03.01.2014, 12:14 -0700 schrieb Eric Nelson:
> >>> This is an issue we've seen before. The SABRE Lite board has
> >>> a voltage divider on the HPD pins and some monitors (esp. DVI
> >>> monitors) either don't drive things high enough to assert HPD or
> >>> bounce with connect/disconnect.
> >>
> >> Yes, I used a DVI monitor.
> >>
> >>> We've instrumented our 3.0.35 kernels to use the RX_SENSE bits
> >>> instead.
> >>
> >> Reacting to RX_SENSE0 instead of HPD seems to work.
> >
> > However, it's non-compliant, because HPD can be lowered and raised by
> > the sink when it changes its EDID data (eg, because you're connected
> > through a switch and the routing has been changed.)
> >
> > So, reacting to RX_SENSE0 instead of HPD has to be a work-around enabled
> > only for those boards which are broken in this regard.
> >
> 
> I understand. We'll need to carry some patches for a while though,
> since there are lots of these boards in the wild.

Could you point me to your changes? Maybe this could be added to
mainline as a quirk enabled by a device tree property on sabrelite only.

regards
Philipp
