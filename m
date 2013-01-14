From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 14 Jan 2013 18:47:35 +1300
Subject: [Bulk] [PATCH] timer: vt8500: Move timer code to
 drivers/clocksource
In-Reply-To: <1358140429.25452.1.camel@gitbox>
References: <1358140171-25390-1-git-send-email-linux@prisktech.co.nz>
 <1358140171-25390-2-git-send-email-linux@prisktech.co.nz>
 <1358140429.25452.1.camel@gitbox>
Message-ID: <1358142455.25591.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-14 at 18:13 +1300, Tony Prisk wrote:
> On Mon, 2013-01-14 at 18:09 +1300, Tony Prisk wrote:
> > This patch moves arch-vt8500/timer.c into drivers/clocksource and
> > updates the necessary Kconfig/Makefile options.
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > ---
> >  arch/arm/mach-vt8500/Kconfig       |    1 +
> >  arch/arm/mach-vt8500/Makefile      |    2 +-
> >  arch/arm/mach-vt8500/common.h      |    1 -
> >  arch/arm/mach-vt8500/timer.c       |  184 ------------------------------------
> >  arch/arm/mach-vt8500/vt8500.c      |    1 +
> >  drivers/clocksource/Kconfig        |    3 +
> >  drivers/clocksource/Makefile       |    1 +
> >  drivers/clocksource/vt8500_timer.c |  184 ++++++++++++++++++++++++++++++++++++
> >  include/linux/vt8500_timer.h       |   22 +++++
> >  9 files changed, 213 insertions(+), 186 deletions(-)
> >  delete mode 100644 arch/arm/mach-vt8500/timer.c
> >  create mode 100644 drivers/clocksource/vt8500_timer.c
> >  create mode 100644 include/linux/vt8500_timer.h
> 
> Darn.. forgot the -m again. I'll await your feedback regarding the
> basing of the patch first (and any other feedback), then I'll redo it
> with the correct stats.
> 
> Regards
> Tony P

Oh grr.. forget this completely. It doesn't take into account the
patches I already sent for WM8850.

I guess it needs to be based on timer/cleanup + vt8500/wm8x50.

Need a little advise on how to handle this one please :)

Regards
Tony P
