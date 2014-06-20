From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 19:48:00 -0400
Subject: [PATCHv4 2/4] ARM: Kirkwood: Add DT descriptions for net2big
 and net5big.
In-Reply-To: <20140620233718.GV20207@kw.sim.vm.gnt>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1401132591-26305-3-git-send-email-andrew@lunn.ch>
 <20140620233718.GV20207@kw.sim.vm.gnt>
Message-ID: <20140620234800.GR21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 01:37:18AM +0200, Simon Guinot wrote:
> On Mon, May 26, 2014 at 09:29:49PM +0200, Andrew Lunn wrote:
> > Describe LaCie 2Big and 5Big Network v2 using device tree.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > v1->v2
> > Fix size of memory
> > Clean up ethernet nodes
> > s/at/atmel/
> > 
> > v2->v3
> > gpio_poweroff->gpio-poweroff
> > gpio_key->gpio-key
> > s/ok/okay
> > Remove spi pinctrl properties.
> > 
> > v3->v4
> > Add _v2 to compatible name of devices
> > Fix SoC version to 6281
> > tabification of DT files
> > Add fan controller and clock node for fan controller
> > ---
> >  arch/arm/boot/dts/Makefile              |   2 +
> >  arch/arm/boot/dts/kirkwood-net2big.dts  |  30 ++++++
> >  arch/arm/boot/dts/kirkwood-net5big.dts  |  83 +++++++++++++++
> >  arch/arm/boot/dts/kirkwood-netxbig.dtsi | 180 ++++++++++++++++++++++++++++++++
> >  4 files changed, 295 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi
> 
> ...
> 
> > diff --git a/arch/arm/boot/dts/kirkwood-net5big.dts b/arch/arm/boot/dts/kirkwood-net5big.dts
> > new file mode 100644
> > index 000000000000..f665fcd6005b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/kirkwood-net5big.dts
> > @@ -0,0 +1,83 @@
> > +/*
> > + * Device Tree file for LaCie 5Big Network v2
> > + *
> > + * Copyright (C) 2014
> > + *
> > + * Andrew Lunn <andrew@lunn.ch>
> > + *
> > + * Based on netxbig_v2-setup.c,
> > + * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > +*/
> > +
> > +/dts-v1/;
> > +
> > +#include "kirkwood.dtsi"
> > +#include "kirkwood-6281.dtsi"
> > +#include "kirkwood-netxbig.dtsi"
> > +
> > +/ {
> > +	model = "LaCie 5Big Network v2";
> > +	compatible = "lacie,net2big_v2", "lacie,netxbig", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> 
> "lacie,net2big_v2" must be replaced with "lacie,net5big_v2".
> 
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x20000000>;
> > +	};
> > +
> > +};
> > +
> > +&regulators {
> > +	regulator at 3 {
> > +		compatible = "regulator-fixed";
> > +		reg = <3>;
> > +		regulator-name = "hdd2power";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		gpio = <&gpio0 19 GPIO_ACTIVE_HIGH>;
> 
> 19 must be replaced with 9.
> 
> > +	};
> > +
> > +	regulator at 4 {
> > +		compatible = "regulator-fixed";
> > +		reg = <4>;
> > +		regulator-name = "hdd3power";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>;
> 
> 20 must be replaced with 10.
> 
> > +	};
> > +
> > +	regulator at 5 {
> > +		compatible = "regulator-fixed";
> > +		reg = <5>;
> > +		regulator-name = "hdd4power";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> 
> 21 must be replaced with 11.
> 
> Andrew, with all this changes, I can confirm that the 2Big and 5Big
> Network v2 boards are working as expected.
> 
> Tested-by: Simon Guinot <simon.guinot@sequanux.org>

Changes squashed in and pushed with your Tested-by.

thx,

Jason.
