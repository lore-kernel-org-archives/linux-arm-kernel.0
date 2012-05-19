From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 00:21:34 -0600
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <4FB225DC.6090805@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB225DC.6090805@codethink.co.uk>
Message-ID: <20120519062134.4AEB03E046E@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2012 10:46:04 +0100, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 15/05/12 09:54, Thomas Petazzoni wrote:
> > This patch adds basic source files for Marvell Armada SoCs.
> >
> > Signed-off-by: Gregory CLEMENT<gregory.clement@free-electrons.com>
> > Signed-off-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> > Signed-off-by: Lior Amsalem<alior@marvell.com>
> > ---
> >   arch/arm/boot/dts/a370.dtsi        |   23 ++++
> >   arch/arm/boot/dts/armada.dtsi      |   67 ++++++++++
> >   arch/arm/boot/dts/axp.dtsi         |   43 +++++++
> >   arch/arm/mach-armada/Kconfig       |    5 +
> >   arch/arm/mach-armada/Makefile      |    2 +
> >   arch/arm/mach-armada/Makefile.boot |    1 +
> >   arch/arm/mach-armada/common.c      |   56 +++++++++
> >   arch/arm/mach-armada/common.h      |   27 ++++
> >   arch/arm/mach-armada/irq.c         |  116 +++++++++++++++++
> >   arch/arm/mach-armada/time.c        |  243 ++++++++++++++++++++++++++++++++++++
> >   10 files changed, 583 insertions(+)
> >   create mode 100644 arch/arm/boot/dts/a370.dtsi
> >   create mode 100644 arch/arm/boot/dts/armada.dtsi
> >   create mode 100644 arch/arm/boot/dts/axp.dtsi
> >   create mode 100644 arch/arm/mach-armada/Kconfig
> >   create mode 100644 arch/arm/mach-armada/Makefile
> >   create mode 100644 arch/arm/mach-armada/Makefile.boot
> >   create mode 100644 arch/arm/mach-armada/common.c
> >   create mode 100644 arch/arm/mach-armada/common.h
> >   create mode 100644 arch/arm/mach-armada/irq.c
> >   create mode 100644 arch/arm/mach-armada/time.c
> >
> > diff --git a/arch/arm/boot/dts/a370.dtsi b/arch/arm/boot/dts/a370.dtsi
> > new file mode 100644
> > index 0000000..f11e56a
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/a370.dtsi
> > @@ -0,0 +1,23 @@
> > +/*
> > + * Device Tree Include file for Marvell Armada 370 family SoC
> > + *
> > + * Copyright (C) 2012 Marvell
> > + *
> > + * Lior Amsalem<alior@marvell.com>
> > + * Gregory CLEMENT<gregory.clement@free-electrons.com>
> > + * Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + *
> > + * Contains definitions specific to the Armada 370 SoC that are not
> > + * common to all Armada SoCs.
> > + */
> > +
> > +/include/ "armada.dtsi"
> 
> I would use armada_xp.dtsi at the least, we've no way of knowing what
> further Armada devices are going to be produced and whether they will be
> compatible with.
> 
> > +/ {
> > +	model = "Marvell Armada 370 family SoC";
> > +	compatible = "marvell,armada370", "marvell,armada";
> > + };
> 
> Firstly, it is mrvl, not marvell everywhere else in the kernel (see
> MIPS and device tree documentation).
> 
> Secondly, I would strongly advise against using the generic marketing
> name for these devices in the compatible list, "marvell,armada" as we
> have no way of knowing what new devices will come along in the future
> and if they'll be compatible.
> 
> > diff --git a/arch/arm/boot/dts/armada.dtsi b/arch/arm/boot/dts/armada.dtsi
> > new file mode 100644
> > index 0000000..3c99c30
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/armada.dtsi
> > @@ -0,0 +1,67 @@
> > +/*
> > + * Device Tree Include file for Marvell Armada family SoC
> > + *
> > + * Copyright (C) 2012 Marvell
> > + *
> > + * Lior Amsalem<alior@marvell.com>
> > + * Gregory CLEMENT<gregory.clement@free-electrons.com>
> > + * Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + *
> > + * This file contains the definitions that are common to the Armada
> > + * 370 and Armada XP SoC.
> 
> I really do not want to see these files in the kernel, we where suppose
> to remove any specific manchine dependency by moving to device tree and
> not push the problem from a board.c to a .dts file.
> 
> Given these really should be part of the bootloader, I am not sure if a
> GPLv2 compliant license is really appropriate for these files. At best
> some form of dual-licensing to allow them to be moved out into a devtree
> repository elsewhere would be useful.
> 
> (Feedback from Grant here would be useful)

Without another repository the kernel tree is the correct place to
put these files.  I certainly don't want them considered as part of
the boot loader either since there needs to be the base expectation
that this data may need to change.  Please do keep them in
arch/arm/boot/dts for now.

g.
