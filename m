From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Apr 2013 16:26:15 +0200
Subject: [PATCH v2 2/3] ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
In-Reply-To: <517692FD.9080005@samsung.com>
References: <1366036922-4103-1-git-send-email-t.figa@samsung.com>
 <201304222310.34775.arnd@arndb.de> <517692FD.9080005@samsung.com>
Message-ID: <1696892.zdvbYPFFr0@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Tuesday 23 of April 2013 22:56:13 Kukjin Kim wrote:
> On 04/23/13 06:10, Arnd Bergmann wrote:
> > On Monday 15 April 2013, Tomasz Figa wrote:
> >> This patch extends exynos_init_time() function to handle Exynos4210 rev0
> >> SoC, which differs in availability of system timers and needs different
> >> clocksource initialization.
> >> 
> >> This makes it possible to use exynos_init_time() function as init_time
> >> callback for all Exynos-based boards, including Universal_C210, which
> >> originally had to use samsung_timer_init().
> >> 
> >> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
> > 
> > Acked-by: Arnd Bergmann<arnd@arndb.de>
> > 
> > Note that it would be helpful to mention here that this is required for
> > the calling samsung_timer_init from the exynos4-dt.c file.
> 
> I did 'amend' as per your suggestion and added your ack on this series.
> 
> Thanks.
> 
> - Kukjin

Since the samsung-time rework patches were replaced with a non-invasive subset 
with different semantics (going to send them in a while), this patch should be 
replaced with new version I'm going to send (in a while as well).

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework
