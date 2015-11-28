From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sat, 28 Nov 2015 20:47:19 +0100
Subject: [PATCH 1/2] ARM: dts: imx6: Add support for Toradex Apalis SoM
In-Reply-To: <ecfde8366160cb17f7b1e571f81488de@agner.ch>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
 <1447935900-13635-2-git-send-email-ynezz@true.cz>
 <1447942325.3144.86.camel@pengutronix.de>
 <ecfde8366160cb17f7b1e571f81488de@agner.ch>
Message-ID: <20151128194719.GO19674@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Agner <stefan@agner.ch> [2015-11-27 11:38:44]:

> >> + * Copyright 2014-2015 Toradex AG
> >> + * Copyright 2012 Freescale Semiconductor, Inc.
> >> + * Copyright 2011 Linaro Ltd.
> >> + *
> >> + * The code contained herein is licensed under the GNU General Public
> >> + * License. You may obtain a copy of the GNU General Public License
> >> + * Version 2 or later at the following locations:
> >> + *
> >> + * http://www.opensource.org/licenses/gpl-license.html
> >> + * http://www.gnu.org/copyleft/gpl.html
> 
> New device trees typically come with a dual license, X11/GPL. It makes
> sense that we use that too, Toradex agrees...

IANAL, but shouldn't we get some form of relicensing agreement from FSL and
Linaro also?

> >> +	clocks {
> >> +		clk24m: clk24m {
> >> +			compatible = "fixed-clock";
> >> +			#clock-cells = <0>;
> >> +			clock-frequency = <24000000>;
> >> +		};
> >> +	};
> 
> There is a 24Mhz osc defined in imx6qdl.dtsi, but I think that is the
> internal osc? I am not entierly familar with the i.MX6 clocks...
> 
> However, this seems not to be used anywhere and other boards also do not
> define that clock, hence I would drop it.

Ok, I'll try to drop it and will see if everything still works.

> > Were v1.0 modules sold to customers? If not the value of having those
> > supported by mainline is really limited.
> 
> I am inclined to say lets not support them. They anyway lead to
> headaches since you need to use a different U-Boot binary too...
> 
> Petr, do you happen to have one of them?

I've simply dropped support for v1.0 modules in patch v2. I've v1.1 module.

> Can we set fsl,dte-mode to false?

Ok, I'll remove that property.

-- ynezz
