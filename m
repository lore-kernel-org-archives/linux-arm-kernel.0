From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 10:41:37 +0200
Subject: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
In-Reply-To: <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
Message-ID: <20180424084137.7xfwji2gcibxavvt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 23, 2018 at 04:37:33PM +0200, Giulio Benetti wrote:
> Il 22/03/2018 19:05, Maxime Ripard ha scritto:
> > On Wed, Mar 21, 2018 at 09:03:13PM +0100, Giulio Benetti wrote:
> > > The A20-Linova1-7 HMI, also called Q027_2_F which is printed on production
> > > label, is an industrial Human Machine Interface.
> > > It features:
> > > - 512MB DDR RAM
> > > - 1 Sd-card >= 4GB
> > > - 1 Usb otg(programmable via software) with A-Usb Connector
> > > - 1 Usb host
> > > - 1 Buzzer
> > > - 1 Input for LiPo
> > > - 1 Relay to signal absence of power supply
> > > - 1 External Rtc with 56 bytes of ram + CR2032 battery
> > > - 1 7" 24-bits Tft 800x480 with PCap on
> > > - 1 Mono audio 1-watt amplifier
> > > - 1 RS485 port
> > > - 1 Power On Line through +12Vdc reaching 57.600baud,
> > >    from where it can be supplied and placed in a network of 50 units
> > > - exposed jtag pins
> > > 
> > > HMI is supplied from +12Vdc.
> > > Ethernet is absent, so for debugging, need to enable rndis on Usb otg
> > > port through an A-A usb cable.
> > > It comes in different flavours for connector types and can be found with
> > > umounted features as requested by customers.
> > 
> > So this is essentially the same board than in patch 6, but with a
> > different screen?
> > 
> > You should have a single DT then, and handle the two different panels
> > using DT overlays.
> 
> Ok for having different DT overlays.
> But do I have to submit them as patches? Or keep them in my company's repo?
> I ask you this because this involves sending also patches for displays
> and other little modifications to mainline ex:
> - rgb888 pins
> - 2 simple-panels
> - 1 uart iomux pins
> etc.
> 
> If I don't submit those overlays, the other patches wouldn't make sense
> alone as I've seen, just like rgb888 pins.

We don't have a repo for overlays yet

> > > +&usb_otg {
> > > +	dr_mode = "otg";
> > 
> > You're saying that this is a USB-A connector? Then it's not OTG since
> > it doesn't have an ID pin, this is an host.
> 
> Right, with a special overlay I will activate Usb Device for RNDIS,
> so modified as host

That doesn't really make much sense. The USB OTG is wired only using a
daughter board?


> One last question:
> now I have some patch already reviewed-by.
> Do I have to re-submit entire patchset?

Yes

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/3f76ff09/attachment.sig>
