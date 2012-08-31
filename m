From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 31 Aug 2012 02:40:50 -0700
Subject: [PATCH v2 6/9] misc: Generic on-chip SRAM allocation driver
In-Reply-To: <1346405848.5316.11.camel@coredoba.hi.pengutronix.de>
References: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
 <1346405224-20399-7-git-send-email-p.zabel@pengutronix.de>
 <1346405848.5316.11.camel@coredoba.hi.pengutronix.de>
Message-ID: <CAMQu2gxsdeX4z2Zrnb2NW7-gnh2Tyjcxkd2pOMOagkdkHGsgWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 2:37 AM, Jan L?bbe <jlu@pengutronix.de> wrote:
>
> On Fri, 2012-08-31 at 11:27 +0200, Philipp Zabel wrote:
> > This driver requests and remaps a memory region as configured in the
> > device tree. It serves memory from this region via the genalloc API.
> >
> > Other drivers can retrieve the genalloc pool from a phandle pointing
> > to this drivers' device node in the device tree.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/misc/Kconfig  |    8 ++++
> >  drivers/misc/Makefile |    1 +
> >  drivers/misc/sram.c   |  105
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 114 insertions(+)
> >  create mode 100644 drivers/misc/sram.c
>
> We now have drivers/memory, which seems to be a good place for this.
>
drivers/memory is created for Memory controller device drivers. SRAM is
just pool of memory and should belong to some other place.

Regards
Santosh
