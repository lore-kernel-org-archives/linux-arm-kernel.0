From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 08 Jul 2014 17:45:55 +0200
Subject: [PATCH 6/6] ARM: EXYNOS: Register cpuidle device only on
 Exynos4210 and 5250
In-Reply-To: <038b01cf9ab7$0de5a440$29b0ecc0$@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403618235-19353-7-git-send-email-t.figa@samsung.com>
 <038b01cf9ab7$0de5a440$29b0ecc0$@samsung.com>
Message-ID: <156099171.AcKbd1QIut@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, July 08, 2014 11:15:21 PM Kukjin Kim wrote:
> Tomasz Figa wrote:
> > 
> > Currently, the Exynos cpuidle driver works correctly only on Exynos4210
> > and 5250. Trying to use it with just one CPU online on any other Exynos
> > SoC will lead to system failure, due to unsupported AFTR mode on other
> > SoCs. This patch fixes the problem by registering the driver only on
> > supported SoCs and letting others simply use default WFI mode until
> > support for them is added.
> > 
> Hmm...I thought other SoCs have no problem on cpuidle except exynos5420 and
> exynos5440....something like this would be helpful to avoid system failure.
> But unfortunately this conflicts with Pankaj's cleanup cpufreq_init() and
> cpuidle_init() patch you've reviewed and I've applied in my local...
> 
> I'm going to check which exynos is ok on cpuidle and then sort them out.

Tomasz's patch is correct - currently only Exynos4210 and Exynos5250 work
fine with AFTR mode and upstream kernel (AFTR gets triggered by offlining
CPUs other than CPU0).

[ Exynos4x12 and Exynos3250 need secure firmware support (patches for this
  need to be reworked on top of recent PM/firmware/cpuidle changes).

  Exynos5410 should use big_little cpuidle driver. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
