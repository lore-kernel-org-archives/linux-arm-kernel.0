From: benoar@dolka.fr (Benjamin Cama)
Date: Sun, 21 Jun 2015 19:56:55 +0200
Subject: [RFC PATCH] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <20150620173421.GJ2936@io.lakedaemon.net>
References: <1434765234.5177.25.camel@dolka.fr>
 <20150620173421.GJ2936@io.lakedaemon.net>
Message-ID: <1434909415.5657.33.camel@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Le samedi 20 juin 2015 ? 17:34 +0000, Jason Cooper a ?crit :
> On Sat, Jun 20, 2015 at 03:53:54AM +0200, Benjamin Cama wrote:
> 
> From here -----vvvv
> 
> > Hi,
> > 
> > This is my conversion patch to DT for my Linkstation Mini. The name of
> > the file better reflects the manufacturer's device name (LS-WSGL), as
> > there also exists a newer Linkstation Mini (LS-WSXL) based on Kirkwood
> > (and as Andrew noted, a patch for it landed yesterday). I did not
> > actually re-test it from clean build (it worked fine before, modulo
> > some cosmetics fixes), as I had a problem with the hardware that I am
> > going to fix soon, but I wanted some comments on it. I included
> > Andrew's remarks, even though I do not know what to do about the
> > buttons name for now: I don't know how the switch is wired exactly for
> > now, and FYI the ???auto-power??? is an intermediate position between off
> > and power that in the original firmware does some wake-up/sleep of the
> > disks when the backup utility is run from the PC connected to the NAS.
> > I never used it and do not know what to do with it, and what ???key???
> > should be associated with it.
> 
> To here -----^^^^^
> 
> Is very conversational.  This should be a more technical description of
> the changes being made as this is the block that 'git am' will use for
> the commit message.  Then the conversational bits go ...
> 
> > 
> > Signed-off-by: Benjamin Cama <benoar@dolka.fr>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> 
> right here, below the '---'.

Thanks, I didn't know there was a way to do that. As it was an RFC, I
didn't bother separating the chatting, sorry.

> 
> >  arch/arm/boot/dts/Makefile           |   3 +-
> >  arch/arm/boot/dts/orion5x-lswsgl.dts | 241 ++++++++++++++++++++++++++++++
> >  arch/arm/mach-orion5x/Kconfig        |   6 +-
> >  arch/arm/mach-orion5x/lsmini-setup.c | 280 -----------------------------------
> >  4 files changed, 246 insertions(+), 284 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/orion5x-lswsgl.dts
> >  delete mode 100644 arch/arm/mach-orion5x/lsmini-setup.c
> 
> Ahhh, that's always refreshing to see...
> 
> > diff --git a/arch/arm/boot/dts/orion5x-lswsgl.dts b/arch/arm/boot/dts/orion5x-lswsgl.dts
> > new file mode 100644
> > index 0000000..c7537a6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/orion5x-lswsgl.dts
> > @@ -0,0 +1,241 @@
> > +/*
> > + * Copyright (C) 2015 Benjamin Cama <benoar@dolka.fr>
> > + * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > + * Copyright (C) 2008 Alexey Kopytko <alexey@kopytko.ru>
> 
> It may be preferable to say "Based on the board file
> arch/arm/mach-orion5x/lsmini-setup.c, Copyright (C) 2008 Alexey Kopytko
> <alexey@kopytko.ru>"  But that's very nit-picky.  As long as Alexey is
> recognized, it should be fine.

OK, I'll do that.

> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2. This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> 
> We're trying to move the dts{i} files to dual license.  Please take a
> look at the current armada-*.dts{i} license blocks.  If you are ok with
> it, please change the above to match.

OK, so this is moving to dual-licensed GPLv2+ and X11? I am OK with it,
if Alexey and Thomas are too (Thomas, your Armada changes are dual
-licensed while your orion5x and GPLv2 only; is this because of the
previous work licences?).

Regards,
--
benjamin
