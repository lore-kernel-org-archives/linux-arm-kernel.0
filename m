From: balbi@ti.com (Felipe Balbi)
Date: Tue, 17 Jun 2014 20:30:05 -0500
Subject: [PATCH 2/2] arm: dts: add support for AM437x StarterKit
In-Reply-To: <20140616072720.GX17845@atomide.com>
References: <1402676147-3711-1-git-send-email-balbi@ti.com>
 <1402676147-3711-3-git-send-email-balbi@ti.com>
 <20140613162334.GI8319@saruman.home>
 <20140613163118.GJ8319@saruman.home>
 <20140616072720.GX17845@atomide.com>
Message-ID: <20140618013004.GA16868@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 16, 2014 at 12:27:21AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140613 09:33]:
> > On Fri, Jun 13, 2014 at 11:23:34AM -0500, Felipe Balbi wrote:
> > > On Fri, Jun 13, 2014 at 11:15:47AM -0500, Felipe Balbi wrote:
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> > > > @@ -0,0 +1,539 @@
> > > > +/*
> > > > + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > > > +
> > > > +/* AM437x SK EVM */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "am4372.dtsi"
> > > > +#include <dt-bindings/pinctrl/am43xx.h>
> > > > +#include <dt-bindings/pwm/pwm.h>
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/input/input.h>
> > > > +
> > > > +/ {
> > > > +	model = "TI AM437x SK EVM";
> > > > +	compatible = "ti,am437x-sk-evm","ti,am4372","ti,am43";
> > > > +
> > > > +	aliases {
> > > > +		display0 = &lcd0;
> > > > +	};
> > > > +
> > > > +	vmmcsd_fixed: fixedregulator-sd {
> > > > +		compatible = "regulator-fixed";
> > > > +		regulator-name = "vmmcsd_fixed";
> > > > +		regulator-min-microvolt = <3300000>;
> > > > +		regulator-max-microvolt = <3300000>;
> > > > +		enable-active-high;
> > > > +	};
> > > > +
> > > > +	v33_fixed: fixedregulator-v33 {
> > > > +		compatible = "regulator-fixed";
> > > > +		regulator-name = "v33_fixed";
> > > > +		regulator-min-microvolt = <3300000>;
> > > > +		regulator-max-microvolt = <3300000>;
> > > > +		enable-active-high;
> > > > +	};
> > > > +
> > > > +	v18_fixed: fixedregulator-v18 {
> > > > +		compatible = "regulator-fixed";
> > > > +		regulator-name = "v18_fixed";
> > > > +		regulator-min-microvolt = <1800000>;
> > > > +		regulator-max-microvolt = <1800000>;
> > > > +		enable-active-high;
> > > > +	};
> 
> Chances are these are not fixed regulators.. Typically the these
> come from external regulators controlled by GPIO pins. Sounds
> like you have the schematics so it would be best to verify it.
> If they come from something not yet supported, let's at least
> document it with comments.

sure, let me just make sure of it.

> Also looks like all the am43xx boards are using vmmcsd_fixed,
> might be worth checking those as well while at it.

I'll need help testing, but sure thing.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/d716fc9f/attachment.sig>
