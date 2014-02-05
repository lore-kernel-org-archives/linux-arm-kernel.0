From: mporter@linaro.org (Matt Porter)
Date: Wed, 5 Feb 2014 09:38:00 -0500
Subject: [PATCH RESEND] ARM: dts: add BeagleBone Audio Cape (Rev A) dtsi
In-Reply-To: <52F2460C.3080908@ti.com>
References: <1391608084-12665-1-git-send-email-ml@embed.me.uk>
 <52F2460C.3080908@ti.com>
Message-ID: <20140205143800.GB22153@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 08:09:16AM -0600, Nishanth Menon wrote:
> On 02/05/2014 07:48 AM, Jack Mitchell wrote:
> > From: Jack Mitchell <jack@embed.me.uk>
> > 
> > Devicetree include file for setting up the am335x mcasp bus, i2c-2
> > bus, and audio codec required for a functioning BeagleBone Audio Cape.
> > 
> > Signed-off-by: Jack Mitchell <jack@embed.me.uk>
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> > ---
> >  arch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi | 124 +++++++++++++++++++++
> >  arch/arm/boot/dts/am335x-bone-common.dtsi          |  14 +++
> >  2 files changed, 138 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi b/arch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi
> > new file mode 100644
> > index 0000000..b8ec3dc
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi
> > @@ -0,0 +1,124 @@
> > +/*
> > + * Copyright (C) 2014 Jack Mitchell <jack@embed.me.uk>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * In order to enable the BeagleBone Audio Cape this dtsi must be
> > + * incuded in the top level dts. On BeagleBone Black hardware the
> > + * status of the HDMI dts node must also be set to "disabled".
> > + *
> > + * --- a/arch/arm/boot/dts/am335x-bone.dts
> > + * +++ b/arch/arm/boot/dts/am335x-bone.dts
> > + * @@ -9,6 +9,7 @@
> > + *
> > + *  #include "am33xx.dtsi"
> > + *  #include "am335x-bone-common.dtsi"
> > + * +#include "am335x-bone-audio-cape-reva.dtsi"
> > + *
> > + *  &ldo3_reg {
> > + *  	regulator-min-microvolt = <1800000>;
> > + *
> > + * On BeagleBone Black hardware the status of the HDMI dts node must
> > + * also be set to "disabled"
> > + *
> > + * --- a/arch/arm/boot/dts/am335x-boneblack.dts
> > + * +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> > + * @@ -73,6 +74,6 @@
> > + *  		pinctrl-names = "default", "off";
> > + *  		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
> > + *  		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
> > + * -		status = "okay";
> > + * +		status = "disabled";
> > + *  	};
> > + *  };
> > + */
> > +
> how about making the audio-cape-reva.dts which includes and overrides
> parameters of boneblack.dts?

Yeah, that might be a little cleaner. Black makes things unfortunately
messy for these capes that were really intended for BBW :(

> Further, I see a bunch of capes in
> http://elinux.org/Beagleboard:BeagleBone_Capes
> 
> Assuming that we dont want to discuss capebus all over again, is this
> the approach we'd like to consider in the interim?

I think that's a fair assumption...I'll note that there is work slowly
in progress on a very minimal implementation DT overlays upstream. But
that doesn't exist. We are simply interested in a sane way to use the
hardware we own in mainline and this approach makes it possible to build
a kernel+dtb from mainline that works for this configuration. If
there's a better way to support this hardware *today* let's discuss it.
One of the big benefits to having this upstream is that it's no longer
out of sight out of mind. It should be managed alongside all the other
am335x dts data.

Incidentally, I'm hoping to contribute a similar patch for the DVI cape
I have here.

-Matt
