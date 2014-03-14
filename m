From: mgr@pengutronix.de (Michael Grzeschik)
Date: Fri, 14 Mar 2014 19:11:04 +0100
Subject: [PATCH 3/3] spi: psdev: add passive serial driver
In-Reply-To: <CACRpkdZoO_hXw-p5ZHeUzMHULq_DEJNzpim0mcO5DBOgP=d60A@mail.gmail.com>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
 <20140312163427.GV28112@sirena.org.uk>
 <20140314101907.GF4234@pengutronix.de>
 <20140314102223.GR366@sirena.org.uk>
 <CACRpkdZoO_hXw-p5ZHeUzMHULq_DEJNzpim0mcO5DBOgP=d60A@mail.gmail.com>
Message-ID: <20140314181104.GA32765@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 02:59:47PM +0100, Linus Walleij wrote:
> On Fri, Mar 14, 2014 at 11:22 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Mar 14, 2014 at 11:19:07AM +0100, Michael Grzeschik wrote:
> >
> >> It is actually not more than that. I took the spidev character device
> >> driver as reference implementation. Any Idea where to put this driver
> >> instead.
> >
> > Like I say somewhere where it sits with other FPGA programming stuff (if
> > that's what it does) would be my first thought.
> 
> I'd suggest you try to use drivers/firmware.
> 
> That subsystem is a bit x86-centrix at the moment but looking at the
> stuff that is in there (like supporting BIOS updates through sysfs and
> other low-level firmware communication) this stuff is close enough.

Indeed, the directory could need some refurbishing. It is also not even
sourced by drivers/Kconfig but instead by the architectures that depend
on it. Beside that, it seems to be the place to be.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
