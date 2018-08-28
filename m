From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 28 Aug 2018 18:00:04 +0530
Subject: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
In-Reply-To: <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
Message-ID: <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> >
> > From: Sunil Goutham <sgoutham@marvell.com>
> >
> > This patch adds basic template for Marvell OcteonTX2's
> > CGX ethernet interface driver. Just the probe.
> > RVU AF driver will use APIs exported by this driver
> > for various things like PF to physical interface mapping,
> > loopback mode, interface stats etc.
> >
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > ---
> >  drivers/soc/marvell/Kconfig            |  10 +++
> >  drivers/soc/marvell/octeontx2/Makefile |   2 +
> >  drivers/soc/marvell/octeontx2/cgx.c    | 117 +++++++++++++++++++++++++++++++++
> >  drivers/soc/marvell/octeontx2/cgx.h    |  20 ++++++
>
> If this is a regular PCI ethernet driver, why do you put it into driver/soc
> rather than drivers/net/ethernet/ ?

No, this is not a ethernet driver, as mentioned in the cover letter
this driver and AF driver doesn't
handle any IO. There will be a separate ethernet driver (will submit
that as well in future) which will
communicate with these drivers for configuring hardware.

The driver in question here is for a serdes controller which handles
physical ethernet interfaces.
Admin function driver gathers info w.r.t current state of physical
ethernet interfaces from this driver
and notifies actual ethernet driver about changes, if any.

Thanks,
Sunil.

>
>       Arnd
