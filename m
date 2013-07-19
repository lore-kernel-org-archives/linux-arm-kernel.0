From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Jul 2013 15:03:25 +0200
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC with
 ARM CPU
In-Reply-To: <20130716151435.GB3871@linaro.org>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org>
Message-ID: <201307191503.25382.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 July 2013, Matt Porter wrote:

> > diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> > new file mode 100644
> > index 0000000..638350d
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> > @@ -0,0 +1,72 @@
> > +/*
> > + * Broadcom BCM47XX / BCM53XX ARM platform code.
> > + *
> > + * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
> > + *
> > + * Licensed under the GNU/GPL. See COPYING for details.
> > + */
> > +
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	compatible = "brcm,bcm5301x";
> 
> Ok, this was nagging at me before I went on my very long vacation. I see
> the "brcm" vendor prefix as a real consistency problem. I noticed on the
> bcm281xx/kona family, we have been using "bcm" which is not logged in
> vendor-prefixes.txt as a legitimate prefix. I see that bcm2835 had
> already established use of "brcm" before any of the bcm281xx support
> came in. Ideally, the vendor prefix should change to "bcm" since every
> reference in the family names is BCM. However, if others want the least
> amount of churn in making this consistent, we might have to go with
> "brcm" across the board.
> 
> Arnd, any thoughts here?

No strong feelings on the bcm vs brcm side, but please make it consistent.

> Last thing, compatible strings are not to have wildcards in them. See
> http://devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
> and note the Warning at the bottom. Also see how bcm2835.txt and
> bcm11351.txt use a specific model.

+1

	Arnd
