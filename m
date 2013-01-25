From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 25 Jan 2013 10:20:38 -0600
Subject: [PATCHv1 for soc 4/5] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <51023E99.7040802@ti.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-5-git-send-email-dinguyen@altera.com>
 <51023E99.7040802@ti.com>
Message-ID: <1359130838.32148.5.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Fri, 2013-01-25 at 13:43 +0530, Santosh Shilimkar wrote:
> On Friday 25 January 2013 06:30 AM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> >
> > mach-socfpga is another platform that needs to use
> > v7_invalidate_l1 to bringup additional cores. There was a comment that
> > the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
> >
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Pavel Machek <pavel@denx.de>
> > ---
> >   arch/arm/mach-imx/headsmp.S      |   47 -------------------------------------
> >   arch/arm/mach-shmobile/headsmp.S |   48 --------------------------------------
> >   arch/arm/mach-tegra/headsmp.S    |   43 ----------------------------------
> >   arch/arm/mm/cache-v7.S           |   47 +++++++++++++++++++++++++++++++++++++
> >   4 files changed, 47 insertions(+), 138 deletions(-)
> >
> Does yor kernel skips the decompresser. Am just curious about
> what you describe above since you should see the issue already
> at decompresser. Your boot loader is expected to clean and
> invalidating the caches before jumping into the kernel.

This is for bringing up the 2nd core after the main CPU is already
alive. Indeed, I did see this issue when the main CPU was coming up and
have changed the bootloader to clean and invalidate the caches.

Dinh
> 
> Regards,
> Santosh
> 
> 
