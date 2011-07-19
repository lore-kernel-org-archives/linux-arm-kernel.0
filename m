From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jul 2011 21:48:33 +0200
Subject: [PATCH 4/7] tty: serial: support device tree in pxa
In-Reply-To: <20110719194010.GI6848@ponder.secretlab.ca>
References: <20110719194010.GI6848@ponder.secretlab.ca>
Message-ID: <1945834.hht9tUJ6C2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 July 2011 13:40:10 Grant Likely wrote:
> On Tue, Jul 19, 2011 at 10:24:47AM +0800, Haojian Zhuang wrote:
> > Support both normal platform driver and device tree driver in serial pxa.
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> > ---
> >  drivers/tty/serial/Kconfig     |    4 +-
> >  drivers/tty/serial/of_serial.c |   12 +++++
> >  drivers/tty/serial/pxa.c       |   93 ++++++++++++++++++++++++++++++++++++++-
> >  include/linux/serial_pxa.h     |   17 +++++++
> >  4 files changed, 122 insertions(+), 4 deletions(-)
> >  create mode 100644 include/linux/serial_pxa.h
> > 
> 
> serial_pxa is already a platform_driver.  Instead of modifying
> of_serial, an of_match_table should be added to this driver and it
> should decode the DT data inside the existing probe hook.
> 
> No need to create all of this extra infrastructure.

Right. We should probably rename of_serial to 8250_of and remove the qpace
parts from the driver.

	Arnd
