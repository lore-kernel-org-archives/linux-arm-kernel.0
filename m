From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 25 Aug 2016 14:15:10 +0000
Subject: [PATCH] ARM: dts: da850: Add missing pin muxing for the UARTs
In-Reply-To: <354081bd-653d-ec98-f18e-eb0b1b1ee7e3@ti.com>
References: <20160804110656.25318-1-kbeldan@baylibre.com>
 <m2eg64pchw.fsf@baylibre.com> <20160804210045.GD15013@gobelin>
 <m2fuqknnqk.fsf@baylibre.com>
 <fe36e8d1-f371-b093-de15-5e03370ea38c@ti.com>
 <dd4712ba-6144-8c64-59a6-7673936af53c@ti.com>
 <20160824082934.GA20246@gobelin>
 <354081bd-653d-ec98-f18e-eb0b1b1ee7e3@ti.com>
Message-ID: <20160825140507.GA13734@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 07:12:16PM +0530, Sekhar Nori wrote:
> On Wednesday 24 August 2016 02:08 PM, Karl Beldan wrote:
> > On Tue, Aug 23, 2016 at 04:46:03PM +0530, Sekhar Nori wrote:
> >> On Tuesday 23 August 2016 04:39 PM, Sekhar Nori wrote:
> >>> On Friday 05 August 2016 04:30 AM, Kevin Hilman wrote:
> >>>> Karl Beldan <kbeldan@baylibre.com> writes:
> >>>>
> >>>>> On Thu, Aug 04, 2016 at 12:20:27PM -0700, Kevin Hilman wrote:
> >>>>>> Karl Beldan <kbeldan@baylibre.com> writes:
> >>>>>>
> >>>>>>> This adds 2 pinctrl groups (rtscts, rxtx) for each of the 3 UARTs.
> >>>>>>>
> >>>>>>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> >>>>>>
> >>>>>> Should da850-evm be updated to use the serial2_rxtx_pins also?
> >>>>>>
> >>>>> I could not find the EVM schematics on the net and I only have an LCDK,
> >>>>> but according to the code it should, however I can't tell whether flow
> >>>>> control pins are used.
> >>>>
> >>>> Ok, let's just leave it for now, since it's working fine.  Sekhar can
> >>>> fix that up if he can dig up the schematics.
> >>>
> >>> Looks like the flow control pins are being used for McASP also on the
> >>> EVM. So lets leave the EVM as-is.
> >>
> >> Rather, the EVM dts file should be updated to use serial2_rxtx_pins like
> >> the LCDK. Right now it seems to be relying on bootloader to serial2
> >> setup pimux correctly. I can make a patch to fix that. Or if you can do
> >> it, that will be great too.
> >>
> > 
> > Indeed ATM the EVM relies on the bootloader to setup the pin muxing.
> > 
> > I just checked the uart pins routing of the EVM, the dts:
> > - should reclaim serial2_rxtx_pins and serial2_rtscts_pins
> 
> Can you please clarify what you mean by dts should "reclaim". You mean
> move the pins from da850.dtsi to da850-evm.dts or something else?
>

No, in the part you are replying to I am not referring to moving the
pins but reclaiming them. The pins are declared in the dtsi, as they
should. Eg. the LCDK dts reclaims serial2_rxtx_pins but doesn't reclaim
serial2_rtscts_pins while their declarations remain in the dtsi.

The purpose of this part was to clarify what I saw on the schematics
because your emails include the following 2 statements:

> >>> Looks like the flow control pins are being used for McASP also on the
> >>> EVM. So lets leave the EVM as-is.

> >> Rather, the EVM dts file should be updated to use serial2_rxtx_pins like
> >> the LCDK. Right now it seems to be relying on bootloader to serial2

My email was to inform that it concerns the flow control pins of the
UART1 only and that the UART2 flow control pins are not concerned and, 
since they are dedicated to the UART2, should be reclaimed unlike
in the LCDK.

 
Karl
