From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Dec 2013 17:18:06 +0100
Subject: [PATCH 2/2] ARM: mvebu: move Armada 370/XP specific definitions
 to armada-370-xp.h
In-Reply-To: <20131226170454.79529766@skate>
References: <1388046026-332-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1388046026-332-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131226160048.GA19323@lunn.ch> <20131226170454.79529766@skate>
Message-ID: <20131226161806.GC19323@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 05:04:54PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Thu, 26 Dec 2013 17:00:48 +0100, Andrew Lunn wrote:
> 
> > Just a question. How much of armada-370-xp.h is specific to just one
> > of these? Things like all the SMP support is XP only. Does it make
> > sense to have armada-370.h, armada-xp.h, then a shared
> > armada-370-xp.h, followed by common.h?
> > 
> > As more SoCs move in, having a clean well defined structure is going
> > to help with the merging.
> 
> As it is today, none of the contents of armada-370-xp.h are useful for
> Armada 370. However, the "main" file is also named armada-370-xp.c and
> handles both SoC, so it made sense to have a file named armada-370-xp.h
> as well.

Hi Thomas

So thinking about dove, kirkwood, this new SoC, all living in mvebu,
should we have a board-dt.c file which all SoCs share, and then one
.c/.h pair of files per SoC? I'm saying this without looking at the
actual content, so i've no idea is this is actually possible. I guess
we need to do something like this sometime, but does it need to be
now?

	Andrew
