From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 16:36:35 +0200
Subject: [PATCH RFC 00/11] Remove mach-kirkwood
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Message-ID: <8332148.Z1shujgC24@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 16:23:41 Andrew Lunn wrote:
> This is an RFC patchset which removes mach-kirkwood, now that kirkwood
> support has been converted to DT and lives in mach-mvebu.
> 
> It is an RFC because some of the final conversion patches have not yet
> been accepted by maintainers, in particular:
> 
> http://www.spinics.net/lists/arm-kernel/msg328068.html
> 
> which needs to be accepted by the Sound/ASoC maintainer.
> 
> Once the real patchset is posted, without the RFC status, we would
> prefer that each subsystem maintainer takes the relevent patches,
> rather than try to take them all through arm-soc.

Very nice!

We had a couple of conflicts in 3.15 between kirkwood and dove both
getting moved to multiplatform. Any idea how this can be done better
this time?

There are three other series that may or may not make it into 3.16
and that will have conflicts with this one:

- remove mv78xx0
- remove mach-dove
- convert orion5x to multiplatform

If we can decide which ones we should have, we can make sure the
patches correctly build on top of one another or get merged into
one per subsystem.

	Arnd
