From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 16 Dec 2014 09:31:07 +0100
Subject: [PATCH v3 2/3] ARM: socfpga: Add driver for the L3 interconnect
In-Reply-To: <20141215223440.GC27866@amd>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
 <1417292052-12974-3-git-send-email-s.trumtrar@pengutronix.de>
 <20141215223440.GC27866@amd>
Message-ID: <20141216083107.GB13070@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Dec 15, 2014 at 11:34:40PM +0100, Pavel Machek wrote:
> Hi!
> 
> > The L3 interconnect provides Global Programmer View (GPV) registers for every
> > AXI master and slave on the SoC.
> > Although this is just a bunch of bits, syscon is not the right approach for
> > this IP core.
> > The L3 interconnect is configured with a lot of reserved "holes" in its memory
> > space. Just mapping this with regmap, what syscon would do, would lead to the
> > system completely hanging, if one of those areas would be touched.
> > One example for when this might happen is the regmap registers dump in the
> > debugfs.
> 
> Could syscon be extended to take more than one range? Then, you could
> simply list all the ranges in device tree and use syscon...
>

Well it could. The question is, if it should. I don't think it would be a good
idea to abstract away every IP core with a syscon node, just because it works.

> > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > index 76d6bd4da138..11db07da894f 100644
> > --- a/drivers/soc/Kconfig
> > +++ b/drivers/soc/Kconfig
> > @@ -1,6 +1,7 @@
> >  menu "SOC (System On Chip) specific Drivers"
> 
> SoC is usual spelling.
> 

Send patches :-)
This is already mainline and not added here.

> > @@ -0,0 +1,10 @@
> > +#
> > +# SoCFPGA Soc drivers
> 
> SoC.
> 

This however I will fix.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
