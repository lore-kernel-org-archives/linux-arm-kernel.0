From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 16:26:48 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515173909.383a0d8a@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205151527.01156.arnd@arndb.de> <20120515173909.383a0d8a@skate>
Message-ID: <201205151626.49173.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Thomas Petazzoni wrote:
> > I think we can just start with the existing plat-orion directory until
> > someone comes up with a better place.
> 
> So you want us to put all this new source code that typically belongs
> to a mach-* directory into plat-orion/ ?

Well, it's just an idea, since it would make sense to move
dove/kirkwood/mv78xx0/orion5x closer together anyway, the logical
choice is to use the plat-orion directory for that.

So the stages would be

1. add new platform code into plat-orion
2. move DT-based parts of dove/kirkwood/mv78xx0/orion5x into plat-orion
3. over time phase out the other directories as they fall into disuse
4. rename plat-orion to mach-orion

As you point out, the ugly part of this is that we'd end up having
code in a plat-* directory that doesn't really belong there.

Another way would be to reorganize those directories upfront:

plat-orion -> mach-orion
mach-*/*.c -> mach/orion/*/*.c
mach-*/include/mach/* -> mach-orion/include/mach/*.h

and then go from there. The differences between the headers are fairly
small already, so that should be manageable.

	Arnd
