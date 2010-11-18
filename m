From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Nov 2010 08:49:23 +0100
Subject: [PATCH 00/51] some more imx patches for 2.6.38
In-Reply-To: <AANLkTi=aPsqn4kj2OTJwOdRCyWUQ3md44MgrzEoGTecq@mail.gmail.com>
References: <20101117212821.GF8942@pengutronix.de>
	<AANLkTi=aPsqn4kj2OTJwOdRCyWUQ3md44MgrzEoGTecq@mail.gmail.com>
Message-ID: <20101118074923.GT6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 09:56:20AM +0800, Shawn Guo wrote:
> Hi Uwe,
> 
> 2010/11/18 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> > Some of the patches in this series are already in Sascha's tree, I
> > resend them because several of them got minor fixes.
> >
> > The highlights are that for most devices for i.MX1, i.MX21, i.MX25 and
> > i.MX27 are allocated dynamically which reduces the memory footprint of
> > the kernel. ?Moreover I moved support for i.MX25 to mach-imx targeting a
> > multi-SoC-kernel for i.MX.
> >
> > Later I want to do the same for mx3. ?I'm not sure about mx5 though.
> > The discussion about integrating support for i.MX28 into mach-imx made
> > me questioning if this is sensible. ?Well, we'll see.
> >
> You are moving mach-mx25 into mach-imx, will do the same for mx3, and
> thinking about the same for mx5. But you are asking me to move mx28
> out of mach-imx.  This only makes sense for me if you think mx28 will
> not go into mach-imx forever.  Are you sure about this? Otherwise we
> are doing something really bothering ourselves.

All i.MX (not i.MX23/28) share the same irq code, timer code, gpio code,
iomuxer code and audio muxer code; admittedly in different variants. So
it makes sense to put them together. All the i.MX28 has in common with
the other i.MX is the fec, which is under drivers/net anyway.
If we start to put i.MX23/28 into mach-imx we could equally well start
to put mach-s3c or whatever there, too.
I know that it's technically possible to do this, and I also think that
it's possible in a performance friendly way, but at this point it starts
to get an architecture wide ARM problem and not a mach-* problem
anymore.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
