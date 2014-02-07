From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Feb 2014 10:15:22 -0500
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140207160954.69fbca38@skate>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <20140207093313.1a979a8f@skate>
 <20140207150306.GX8533@titan.lakedaemon.net>
 <20140207160954.69fbca38@skate>
Message-ID: <20140207151522.GZ8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 04:09:54PM +0100, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Fri, 7 Feb 2014 10:03:06 -0500, Jason Cooper wrote:
> 
> > Ideally, I'd prefer multi_v7 and multi_v5 for DT, and
> > {kirkwood,dove,orion5x,mv78xx0}_defconfig for non-DT legacy building.
> > The latter going away once we deprecate non-DT booting.  There is a case
> > to be made for the arch-specific defconfigs, though.
> > 
> > Currently (includes modules if configured, and dtbs);
> > 
> >   mvebu_defconfig	00:02:56
> >   x86_64_defconfig	00:04:24
> >   multi_v7_defconfig	00:04:05
> > 
> > 1 minute and 9 seconds doesn't drastically change a bathroom break or
> > tea time ;-)  But it is a 33% increase.
> 
> I also like to have a more focused defconfig than multi_v7 for
> development.
> 
> > If we want something leaner than multi_v7, how about
> > armada_370-xp_defconfig to replace the current mvebu_defconfig?
> 
> Doesn't work for me: we're going to introduce soon the support for
> other mvebu ARMv7 SoC that are not Armada 370 nor XP, but that should
> be built as part of this.
> 
> Why not mvebu_v7 and mvebu_v5 as I suggested? mvebu_v7 would build both
> Dove and Armada 370/XP (and the other ones we are going to introduce
> soon), mvebu_v5 would build Kirkwood (and possibly Orion5x once I find
> enough time to work on this platform).

Yeah, I can go with that, as long as Sebastian doesn't see a need for a
separate dove_defconfig in the long term (DT only).  Sebastian?

> This way, ultimately we can simply remove kirkwood_defconfig and
> dove_defconfig, as soon as all legacy platforms have been either
> converted to DT, or removed.

Yep, the fewer builds I have to do per patch submission, the better.

thx,

Jason.
