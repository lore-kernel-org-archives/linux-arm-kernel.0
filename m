From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 8 Apr 2011 12:46:49 +0200
Subject: [PATCH V4 0/4] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <4D9E75FF.6090603@freescale.com>
References: <19869.40520.368078.270732@ipc1.ka-ro>
	<4D9E75FF.6090603@freescale.com>
Message-ID: <19870.59289.913018.127715@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> Hi Lothar:
> > Hi,
> >
> > Huang Shijie writes:
> >> Does some one have any comments about this driver?
> >>
> > I'm still not happy with the rom-helper code that IMO does not belong
> > in this driver.
> Could you tell me which part of the rom-helper code is not belong the 
> driver?
> 
All of it. I don't see a point in having it, when all that it does can
be achieved with standard functions already.

> > Also, I would integrate the code from the hal-*.c files into the main
> > file and remove all the function hooks, since the functions are the
> thanks for your advice.
> 
> This driver will serve for many platforms, not only the imx23 and imx28.
> I am merging the imx508 code to the driver.
> I feel lucky that i did not merge all the code into the main file, which 
> will
> make the code mess.
> 
You would probably end up with some more functions that are
implemented for the different variants. They could be prefixed with
the SoC name and selected in the probe() function depending on the
platform id. I don't see why this should get messy.

If the imx508 driver is so much different from the other variants,
that merging it gets too messy, it's probably better to not merge it
with the other variants anyway.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
