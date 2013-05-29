From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 29 May 2013 11:16:14 +0200
Subject: [PATCH] ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
In-Reply-To: <120501ce5752$6daef380$490cda80$%kim@samsung.com>
References: <1368630484-29939-1-git-send-email-t.figa@samsung.com>
 <1623377.nVo7nUcid2@flatron> <120501ce5752$6daef380$490cda80$%kim@samsung.com>
Message-ID: <51A5C75E.7090006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 5/23/2013 3:11 AM, Kukjin Kim wrote:
> Kukjin Kim wrote:
> >
> > Tomasz Figa wrote:
> > >
> > > Hi Kukjin,
> > >
> > Hi,
> >
> > > On Wednesday 15 of May 2013 17:08:04 Tomasz Figa wrote:
> > > > This patch extends exynos_init_time() function to handle Exynos4210
> > rev0
> > > > SoC, which differs in availability of system timers and needs
> > different
> > > > clocksource initialization.
> > > >
> > > > This makes it possible to use exynos_init_time() function as init_time
> > > > callback for all Exynos-based boards, including Universal_C210, which
> > > > originally had to use samsung_timer_init().
> > > >
> > > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > > ---
> > > >  arch/arm/mach-exynos/Kconfig               |  3 ++-
> > > >  arch/arm/mach-exynos/common.c              | 30
> > > > +++++++++++++++++++++++++++++- arch/arm/mach-exynos/common.h
> > > >   |  2 ++
> > > >  arch/arm/mach-exynos/mach-universal_c210.c |  5 ++---
> > > >  4 files changed, 35 insertions(+), 5 deletions(-)
> > >
> > > Could you pick this patch to your fixes branch?
> > >
> > Yeah, I will after looking at.
> >
> > > This is a fix of a regression in handling Exynos4210 rev0 SoC (e.g.
> > > Universal C210 board) introduced by patches merged to 3.10.
> > >
> > OK, I see but I didn't review yet and I  will within a couple of days ;-)
> >
> OK, looks fine, this will be sent to upstream during -rc for v3.10.
>
> But, Tomasz, as you know, non-DT supporting files will be gone away in
> v3.11, just note.

This patch is needed to get REV0 4210 based board working both in DT and 
non-DT
modes.

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
