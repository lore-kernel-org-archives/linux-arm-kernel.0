From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 08:18:22 -0800
Subject: [PATCH 3/3] drivers: bus: Move omap gpmc code to live under
 drivers
In-Reply-To: <3449576.YFhSXUYQOn@wuerfel>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
 <1416522501-14999-4-git-send-email-tony@atomide.com>
 <546F0299.1070508@ti.com> <3449576.YFhSXUYQOn@wuerfel>
Message-ID: <20141121161821.GS7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [141121 03:17]:
> On Friday 21 November 2014 11:15:05 Roger Quadros wrote:
> > On 11/21/2014 12:28 AM, Tony Lindgren wrote:
> > > Just move to drivers as further clean-up can now happen there
> > > finally.
> 
> Awesome!
> 
> > >  arch/arm/mach-omap2/Kconfig                           | 1 +
> > >  arch/arm/mach-omap2/Makefile                          | 2 +-
> > >  drivers/bus/Kconfig                                   | 3 +++
> > >  drivers/bus/Makefile                                  | 3 ++-
> > >  arch/arm/mach-omap2/gpmc.c => drivers/bus/omap-gpmc.c | 0
> > >  5 files changed, 7 insertions(+), 2 deletions(-)
> > >  rename arch/arm/mach-omap2/gpmc.c => drivers/bus/omap-gpmc.c (100%)
> > 
> > Should we move it to drivers/memory/ instead?
> > TI_AEMIF driver lives there. This is similar to OMAP-GPMC for but for
> > Davinci and Keystone platforms.
> 
> Agreed, using drivers/memory sounds better.

Good point, I forgot we have separate drivers/memory and drivers/bus.

Regards,

Tony
