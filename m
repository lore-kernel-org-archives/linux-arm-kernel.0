From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Dec 2011 10:33:19 +0100
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <7FE21149F4667147B645348EC60578850564C5@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-5-git-send-email-b29396@freescale.com>
 <20111214211152.GM27267@pengutronix.de>
 <CACRpkdYHtgx3Qgx4QRdgOahQXjvSWE_iogWCZjaYQ-VnyS62uQ@mail.gmail.com>
 <20111215070505.GA22541@S2101-09.ap.freescale.net>
 <CACRpkdbN26q1_d4tPkJp4f4_KdvoEEk9uCCRyOfEU97DOWAnEw@mail.gmail.com>
 <7FE21149F4667147B645348EC60578850564C5@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20111215093319.GO27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 08:59:28AM +0000, Dong Aisheng-B29396 wrote:
> > -----Original Message-----
> > From: Linus Walleij [mailto:linus.walleij at linaro.org]
> > Sent: Thursday, December 15, 2011 4:27 PM
> > To: Guo Shawn-R65073
> > Cc: Sascha Hauer; Dong Aisheng-B29396; linus.walleij at stericsson.com;
> > linux-kernel at vger.kernel.org; rob.herring at calxeda.com;
> > grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org;
> > kernel at pengutronix.de
> > Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux
> > subsystem
> > Importance: High
> > 
> > On Thu, Dec 15, 2011 at 8:05 AM, Shawn Guo <shawn.guo@freescale.com>
> > wrote:
> > >[Me]
> > >> So if you want to do this for i.MX you need something like selectable
> > >> dummy pinmuxes, i.e. pinmux_get() to return something that just say
> > >> "OK" to everything like the dummy regulators.
> > >>
> > >> Shall I try to create something like that?
> > >>
> > > Isn't the empty functions defined in include/linux/pinctrl/pinmux.h
> > > for this purpose?
> > 
> > No, these are for compiling it *out*, dummy pinmuxes would be if you
> > compile it *in*, but don't find an apropriate pinmux, you still get
> > something that does nothing and still works.
> > 
> > Dummy regulators work exactly this way.
> > 
> 
> I did not read the dummy regulator code too much.
> But does it mean that the dummy regulator or dummy pinmux will also hide the
> Real errors since it will always get a available one?
> How do we distinguish between the two case(real error and fake error)?

We don't :(

That's the problem with the dummy regulator.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
