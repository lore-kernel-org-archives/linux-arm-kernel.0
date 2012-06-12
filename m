From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 12 Jun 2012 10:24:12 -0400
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <20120612140616.GC17893@lunn.ch>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <201206121349.27696.arnd@arndb.de> <20120612140616.GC17893@lunn.ch>
Message-ID: <20120612142412.GD14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 04:06:16PM +0200, Andrew Lunn wrote:
> > arch/arm/mach-kirkwood/board-* (DT files)
> > 	-> arch/arm/mach-mvebu/
> 
> I know of work being done to make orion5x and dove also support DT.
> Should we consider some sort of prefix or midfix indicating which SoC
> a board file is for? It will not be easy to mentally keep track of
> board-ts209.c is an orion5x and board-ts219.c is kirkwood etc.

The board-BOARD.c files are transitional files, and will disappear once
the DT conversion is done.  All that will remain is board-dt.c.  So,
there is no long-term issue.  Since it's a short term issue, and we're
moving/renaming anyway, how about kirkwood-dreamplug.c, orion5x-ts209.c,
etc?

I personally don't think it's needed, but I have no strong opinion on
it.

thx,

Jason.
