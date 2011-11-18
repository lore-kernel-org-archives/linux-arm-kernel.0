From: rpurdie@rpsys.net (Richard Purdie)
Date: Fri, 18 Nov 2011 10:13:03 +0000
Subject: [PATCH 6/7] ARM: restart: only perform setup for restart when
 soft-restarting
In-Reply-To: <20111117174247.GF9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6b9-0001NG-NS@rmk-PC.arm.linux.org.uk>
 <20111117174247.GF9581@n2100.arm.linux.org.uk>
Message-ID: <1321611183.27449.59.camel@ted>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-11-17 at 17:42 +0000, Russell King - ARM Linux wrote:
> Ack?
> 
> (If you're in the To: list I'm expecting a reply because this patch is
> touching something you're responsible for.  Thanks.)
> 
> On Sun, Nov 06, 2011 at 05:33:35PM +0000, Russell King - ARM Linux wrote:
> > We only need to set the system up for a soft-restart if we're going to
> > be doing a soft-restart.  Provide a new function (soft_restart()) which
> > does the setup and final call for this, and make platforms use it.
> > Eliminate the call to setup_restart() from the default handler.
> > 
> > This means that platforms arch_reset() function is no longer called with
> > the page tables prepared for a soft-restart, and caches will still be
> > enabled.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  arch/arm/include/asm/system.h                     |    1 +
> >  arch/arm/kernel/process.c                         |   13 +++++++++++--
> >  arch/arm/mach-clps711x/include/mach/system.h      |    2 +-
> >  arch/arm/mach-ebsa110/include/mach/system.h       |    2 +-
> >  arch/arm/mach-footbridge/include/mach/system.h    |    2 +-
> >  arch/arm/mach-iop32x/include/mach/system.h        |    2 +-
> >  arch/arm/mach-iop33x/include/mach/system.h        |    2 +-
> >  arch/arm/mach-ixp4xx/include/mach/system.h        |    2 +-
> >  arch/arm/mach-ks8695/include/mach/system.h        |    2 +-
> >  arch/arm/mach-mmp/include/mach/system.h           |    4 ++--
> >  arch/arm/mach-mxs/system.c                        |    2 +-
> >  arch/arm/mach-pnx4008/include/mach/system.h       |    2 +-
> >  arch/arm/mach-pxa/reset.c                         |    2 +-
> >  arch/arm/mach-rpc/include/mach/system.h           |    2 +-
> >  arch/arm/mach-s3c2410/include/mach/system-reset.h |    4 ++--
> >  arch/arm/mach-s3c64xx/include/mach/system.h       |    2 +-
> >  arch/arm/mach-sa1100/include/mach/system.h        |    2 +-
> >  arch/arm/mach-shmobile/include/mach/system.h      |    2 +-
> >  arch/arm/mach-w90x900/include/mach/system.h       |    2 +-
> >  arch/arm/plat-mxc/system.c                        |    2 +-
> >  arch/arm/plat-spear/include/plat/system.h         |    2 +-
> >  21 files changed, 33 insertions(+), 23 deletions(-)
> > 
