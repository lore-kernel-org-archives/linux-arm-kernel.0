From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 23 Feb 2014 16:10:32 -0500
Subject: [PATCH 0/2] Marvell Armada 375 and 38x pinctrl drivers
In-Reply-To: <20140217164406.17d3f59e@skate>
References: <1392051896-19178-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140217164406.17d3f59e@skate>
Message-ID: <20140223211032.GR7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Mon, Feb 17, 2014 at 04:44:06PM +0100, Thomas Petazzoni wrote:
> Linus,
> 
> Do you intend to integrate the following patches for 3.15 ? They have
> been Acked-by Jason Cooper, one of the mvebu maintainer, and are just
> additions of simple mvebu pinctrl drivers that follow the existing
> mvebu pinctrl common logic with nothing fancy.
> 
> We have agreed with Sebastian Hesselbarth, who is doing a more serious
> rework of the pinctrl mvebu stuff, that those two patches should go in
> first, so that they don't miss 3.15.

v4 of Sebastian's rework now depends on this series.  As you've
expressed consent with Sebastian's series going through mvebu/arm-soc,
I'm going to go ahead and pull this into a topic branch as well.

If you'd like the mvebu pinctrl branches to go through your tree, just
let me know and I'll send you a pull request for them.

thx,

Jason.

> On Mon, 10 Feb 2014 18:04:54 +0100, Thomas Petazzoni wrote:
> > Linus,
> > 
> > Here are two patches that add the pinctrl drivers for two new Marvell
> > ARM SOCs that belong to the mach-mvebu family: the Armada 375 and the
> > Armada 380/385. They are based on Cortex-A9 CPU cores, and share a
> > number of peripherals with their predecessors in the mach-mvebu
> > family. pinctrl-wise, they have a completely similar register layout
> > than Armada 370/XP, so only a list of pins and functions has to be
> > introduced, and therefore the drivers are straightforward.
> > 
> > The core support (arch/arm/mach-mvebu) for these SOCs will be posted
> > shortly, and we're aiming at having this merged for 3.15 if possible.
> > 
> > Thanks!
> > 
> > Thomas
> > 
> > Thomas Petazzoni (2):
> >   pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 375
> >   pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 380/385
> > 
> >  .../pinctrl/marvell,armada-375-pinctrl.txt         |  81 ++++
> >  .../pinctrl/marvell,armada-38x-pinctrl.txt         |  79 ++++
> >  drivers/pinctrl/mvebu/Kconfig                      |   8 +
> >  drivers/pinctrl/mvebu/Makefile                     |   2 +
> >  drivers/pinctrl/mvebu/pinctrl-armada-375.c         | 441 ++++++++++++++++++++
> >  drivers/pinctrl/mvebu/pinctrl-armada-38x.c         | 445 +++++++++++++++++++++
> >  6 files changed, 1056 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-375-pinctrl.txt
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-38x-pinctrl.txt
> >  create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-375.c
> >  create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-38x.c
> > 
> 
> 
> 
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
