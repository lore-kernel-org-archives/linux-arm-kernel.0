From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 May 2012 17:11:31 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120521153559.GN24238@titan.lakedaemon.net>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205192042140.13185@xanadu.home>
 <20120520095502.GB25344@n2100.arm.linux.org.uk>
 <201205201058.38144.arnd@arndb.de>
 <20120520111025.GC25344@n2100.arm.linux.org.uk>
 <20120521013050.GL24238@titan.lakedaemon.net>
 <20120521093042.GE25344@n2100.arm.linux.org.uk>
 <20120521153559.GN24238@titan.lakedaemon.net>
Message-ID: <20120521161131.GC24270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 11:35:59AM -0400, Jason Cooper wrote:
> mach-mvebu/'s directory tree structure could be:
> 	include/	# no headers
> 	include/mach/	# headers used by drivers, etc
> 	include/board/	# common headers used by legacy board files
> 	board/		# common source code for legacy board files
> 
> The end goal being to empty and remove the board/'s and remove the other
> mach-*/ directories.

Looking at what's in dove, kirkwood, mv78xx0 and orion5x directories,
I don't see many board specific files.  The only two I can see are
leds-*.h, which are shared with platform drivers in drivers/leds.

We have a place for this already - include/linux/platform_data.

So I don't think we need include/board/ at all.

I'd also suggest going against our current setup of not having "board/"
subdirectories in mach-*.  Just name them board-foo.c.
