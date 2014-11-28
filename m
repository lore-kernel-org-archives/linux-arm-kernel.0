From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 23:41:40 +0100
Subject: [GIT PULL] move omap gpmc to drivers finally
In-Reply-To: <20141128213915.GV2817@atomide.com>
References: <20141126194330.GN2817@atomide.com>
 <201411281228.52786.arnd@arndb.de> <20141128213915.GV2817@atomide.com>
Message-ID: <4073059.QNMRS4hN3Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 13:39:16 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [141128 03:31]:
> > On Wednesday 26 November 2014, Tony Lindgren wrote:
> > >
> > > We can finally move the GPMC code to live in drivers/memory
> > > for further clean up work. This series does the move with
> > > minimal changes to the code.
> > 
> > I just looked at this branch. It's definitely nice to move the code
> > to drivers/memory, but I don't like the idea of having lots of function
> > declarations and internal data structures in a linux/platform_data/*.h
> > file. We can still merge this for 3.19, but I want to make sure you have
> > a plan for getting rid of this (and put that into the tag description).
> > 
> > Does this header file get removed once all non-DT board files are gone?
> 
> Yes that will become driver internal data at that point.

Ok, cool.

> > How about moving the declarations into include/linux/omap-gpmc.h instead?
> 
> OK. Below is an updated pull request with the platform_data/omap-gpmc.h
> dropped.

Pulled into next/omap-gpmc, thanks!

I guess we'll end up merging this branch into next/drivers before submitting,
but I have to see the relative sizes first. If it's a significant chunk of
the drivers changes, we might submit it as one branch to Linus.

	Arnd
