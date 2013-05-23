From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 23 May 2013 12:37:54 +0200
Subject: [PATCH] ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
In-Reply-To: <120501ce5752$6daef380$490cda80$%kim@samsung.com>
References: <1368630484-29939-1-git-send-email-t.figa@samsung.com>
 <1623377.nVo7nUcid2@flatron> <120501ce5752$6daef380$490cda80$%kim@samsung.com>
Message-ID: <1781627.0kos608bv1@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Thursday 23 of May 2013 10:11:17 Kukjin Kim wrote:
> Kukjin Kim wrote:
> > Tomasz Figa wrote:
> > > Hi Kukjin,
> > 
> > Hi,
> > 
> > > On Wednesday 15 of May 2013 17:08:04 Tomasz Figa wrote:
> > > > This patch extends exynos_init_time() function to handle Exynos4210
> > 
> > rev0
> > 
> > > > SoC, which differs in availability of system timers and needs
> > 
> > different
> > 
> > > > clocksource initialization.
> > > > 
> > > > This makes it possible to use exynos_init_time() function as init_time
> > > > callback for all Exynos-based boards, including Universal_C210, which
> > > > originally had to use samsung_timer_init().
> > > > 
> > > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > > ---
> > > > 
> > > >  arch/arm/mach-exynos/Kconfig               |  3 ++-
> > > >  arch/arm/mach-exynos/common.c              | 30
> > > > 
> > > > +++++++++++++++++++++++++++++- arch/arm/mach-exynos/common.h
> > > > 
> > > >   |  2 ++
> > > >  
> > > >  arch/arm/mach-exynos/mach-universal_c210.c |  5 ++---
> > > >  4 files changed, 35 insertions(+), 5 deletions(-)
> > > 
> > > Could you pick this patch to your fixes branch?
> > 
> > Yeah, I will after looking at.
> > 
> > > This is a fix of a regression in handling Exynos4210 rev0 SoC (e.g.
> > > Universal C210 board) introduced by patches merged to 3.10.
> > 
> > OK, I see but I didn't review yet and I  will within a couple of days ;-)
> 
> OK, looks fine, this will be sent to upstream during -rc for v3.10.

Thanks.

> But, Tomasz, as you know, non-DT supporting files will be gone away in
> v3.11, just note.

Sure. This is a good thing.

In 3.11 Universal C210 will be supported only using device tree, but for 3.10 
we need this patch to make the old board file still work.

Best regards,
-- 
Tomasz Figa
Linux Kernel Developer
Samsung R&D Institute Poland
Samsung Electronics
