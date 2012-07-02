From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Jul 2012 21:31:19 +0000
Subject: [PATCH 2/9] arm: mach-mvebu: add header
In-Reply-To: <20120702191616.GJ1348@lunn.ch>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120702210838.37c78fda@skate> <20120702191616.GJ1348@lunn.ch>
Message-ID: <201207022131.19558.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 July 2012, Andrew Lunn wrote:
> > OMAP has some logic to handle this kind of problems, see
> > plat-omap/include/plat/uncompress.h. We can quite certainly overcome
> > this problem somehow.
> 
> That file says:
> 
>          * Initialize the port based on the machine ID from the bootloader.
> 
> Which when using DT we don't have.
> 
> As you said, we can overcome this somehow. We just need to be aware
> there will be changes here.
> 
> It would also be nice if Marvell ASIC engineers didn't randomly move
> things around in the address space....

For now, I'd suggest you don't try too hard to make this work for the
a combination of the mvebu platforms. There has been some discussion
about a solution that will work across multiple platform directories.
While that might take a little longer, I assume that we will find some
way to do it, so let's first unify all the other header files within
mvebu.

	Arnd
