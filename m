From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 8 Jul 2011 12:24:22 +0200
Subject: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for imx23/imx28
In-Reply-To: <20110708101625.GR29624@pengutronix.de>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
	<1309406028-2924-2-git-send-email-b32955@freescale.com>
	<201106301555.19440.arnd@arndb.de>
	<20110708073119.GP29624@pengutronix.de>
	<4E16B47E.8090909@freescale.com>
	<20110708090903.GQ29624@pengutronix.de>
	<4E16CD6F.9050304@freescale.com>
	<20110708101625.GR29624@pengutronix.de>
Message-ID: <19990.56022.592145.982784@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig writes:
> Hello Huang,
> 
> On Fri, Jul 08, 2011 at 05:27:11PM +0800, Huang Shijie wrote:
> > >>>>The init function is used only to set up iomux, so the logical replacement is
> > >>>>a pointer to the iomux data, and calling mxs_iomux_setup_multiple_pads
> > >>>>directly from the driver.
> > >>>Why not put the iomux stuff into the per-machine table and get rid of
> > >>>the init callback, too?
> > >>The mmc (ssp) has pin conflict with gpmi on both mx23evk and mx28evk.
> > >>So, it's better to initialize the pin when the driver(GPMI or MMC)
> > >>is enabled.
> > >What do you do to prevent userspace from trying to use both devices?
> > The board can not support the two devices at the same time.
> > So the user can only use one device with the board.
> > 
> > >I guess you need to configure the hardware somehow to switch between the
> > >two using a jumper? Isn't it possible to detect the hardware setting and
> > >setup the muxer accordingly?
> > >
> > >IMHO an per-device init-callback is the wrong approach to solve a pin
> > >conflict.
> > Do you have any good solution about this?
> Put the pinmux corresponding to the one device that currently works in
> the pinmux list!?
> 
#define 'that currently works'

For a dedicated system that may not be a problem. But for development
kits and modular systems that allow peripheral modules to be plugged
in there is no 'one device that currently works'.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
