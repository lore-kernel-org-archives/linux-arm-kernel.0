From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2011 21:05:15 +0100
Subject: [PATCH 4/7] tty: serial: support device tree in pxa
In-Reply-To: <CACxGe6u1Pq990opdt7irttuY1OvpZVNXSM11cLdqo5zN8YpYeg@mail.gmail.com>
References: <20110719194010.GI6848@ponder.secretlab.ca>
	<1945834.hht9tUJ6C2@wuerfel>
	<CACxGe6u1Pq990opdt7irttuY1OvpZVNXSM11cLdqo5zN8YpYeg@mail.gmail.com>
Message-ID: <20110719200515.GB308@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 01:53:53PM -0600, Grant Likely wrote:
> On Tue, Jul 19, 2011 at 1:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 19 July 2011 13:40:10 Grant Likely wrote:
> >> On Tue, Jul 19, 2011 at 10:24:47AM +0800, Haojian Zhuang wrote:
> >> > Support both normal platform driver and device tree driver in serial pxa.
> >> >
> >> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >> > ---
> >> > ?drivers/tty/serial/Kconfig ? ? | ? ?4 +-
> >> > ?drivers/tty/serial/of_serial.c | ? 12 +++++
> >> > ?drivers/tty/serial/pxa.c ? ? ? | ? 93 ++++++++++++++++++++++++++++++++++++++-
> >> > ?include/linux/serial_pxa.h ? ? | ? 17 +++++++
> >> > ?4 files changed, 122 insertions(+), 4 deletions(-)
> >> > ?create mode 100644 include/linux/serial_pxa.h
> >> >
> >>
> >> serial_pxa is already a platform_driver. ?Instead of modifying
> >> of_serial, an of_match_table should be added to this driver and it
> >> should decode the DT data inside the existing probe hook.
> >>
> >> No need to create all of this extra infrastructure.
> >
> > Right. We should probably rename of_serial to 8250_of and remove the qpace
> > parts from the driver.
> 
> In fact, I think we've got about 3 devtree drivers for 8250 serial
> ports.  I think it is about time for some consolidation work.  :-)
> 
> I wonder if we can roll of_serial directly into the 8250.c driver.

The original serial.c got split into 8250.c, plus several probe modules
(8250_pnp.c, 8250_pci.c, etc) to get around the problem of lots of
bus specific crap appearing in the main driver.  8250_of.c would follow
on that theme.
