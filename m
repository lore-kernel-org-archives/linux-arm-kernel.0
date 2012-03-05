From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 13:38:44 -0800
Subject: [PATCH V3 1/2] mcx: very basic support for HTKW mcx board
In-Reply-To: <20120305195329.GP12083@atomide.com>
References: <1324482822-24221-1-git-send-email-yanok@emcraft.com>
 <1324482822-24221-2-git-send-email-yanok@emcraft.com>
 <20120305195329.GP12083@atomide.com>
Message-ID: <20120305213844.GU12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120305 11:21]:
> * Ilya Yanok <yanok@emcraft.com> [111221 07:22]:
> > Very basic support for HTKW mcx board. Able to boot via board-generic
> > and ramdisk/initramfs, however most of peripherals is unsupported.
> > Produces tons of twl4030 related errors as this board doesn't have
> > twl4030 installed.
> > 
> > Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> 
> Grant, care to ack this one?

Actually a version of this you already acked as
"[PATCH 1/2] mt_ventoux: very basic support for TeeJet Mt.Ventoux board"
so using that instead

Regards,

Tony

> > ---
> > Changes from V2:
> > 
> >  - None
> > 
> > Changes from V1:
> > 
> >  - device tree move to the separate patch
> >  - iva node is disabled instead of using custom includes
> >  - removed bootargs entry
> > 
> >  arch/arm/boot/dts/mcx.dts |   27 +++++++++++++++++++++++++++
> >  1 files changed, 27 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/mcx.dts
> > 
> > diff --git a/arch/arm/boot/dts/mcx.dts b/arch/arm/boot/dts/mcx.dts
> > new file mode 100644
> > index 0000000..66b81bd
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mcx.dts
> > @@ -0,0 +1,27 @@
> > +/*
> > + * Copyright (C) 2011 Ilya Yanok, EmCraft Systems
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +/dts-v1/;
> > +
> > +/include/ "omap3.dtsi"
> > +
> > +/ {
> > +	model = "HTKW mcx";
> > +	compatible = "htkw,mcx", "ti,omap3";
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x80000000 0x10000000>; /* 256 MB */
> > +	};
> > +
> > +	/* AM35xx doesn't have IVA */
> > +	soc {
> > +		iva {
> > +			status = "disabled";
> > +		};
> > +	};
> > +};
> > -- 
> > 1.7.6.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
