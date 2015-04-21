From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 21 Apr 2015 17:43:30 +0200
Subject: [PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
 platform
In-Reply-To: <7h1tjeh5ka.fsf@deeprootsystems.com>
References: <1428946441-17058-1-git-send-email-b.zolnierkie@samsung.com>
 <7h1tjeh5ka.fsf@deeprootsystems.com>
Message-ID: <5439319.JYC6t7bzy4@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, April 20, 2015 02:07:33 PM Kevin Hilman wrote:
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:
> 
> > Hi,
> >
> > This patch series removes the use of Exynos5250 specific support
> > from exynos-cpufreq driver and enables the use of cpufreq-dt driver
> > for this platform.  The exynos-cpufreq driver itself is also removed
> > as it is no longer used/needed after Exynos5250 support removal.
> >
> > This patch series has been tested on Exynos5250 based Arndale board.
> >
> > Depends on:
> > - next-20150330 branch of linux-next kernel tree
> > - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
> >   platform" [1]
> > - "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
> >   platform" [2]
> > - "[PATCH] cpufreq: exynos: remove dead ->need_apll_change method" [3]
> 
> Any chance you could prepare a branch with all the dependencies for easy
> testing?

All cpufreq changes with needed dependencies are now availble in

    https://github.com/bzolnier/linux.git

repository and the branch is

    next-20150330-generic-cpufreq-exynos5420-5800-v2

> Also, The previous version from Thomas was v12, and this one is neither
> versioned nor has any reference to what may have changed since that

Please note that Thomas' patchset was split on separate parts (this is
part #3) and heavily modified so the previous versioning was dropped.

The cover letter of part #1 ("[PATCH 0/6] cpufreq: use generic cpufreq
drivers for Exynos4210 platform") contains detailed changelog on what has
been changed since Thomas' original v12 patch series.  Individual Thomas'
patches which were modified by me also contain such information.

Part #2 ("[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
platform") was entirely new code when compared to Thomas' v12 patchset so
its cover letter doesn't contain such detailed changelog as part #1.

The newly posted part #4 ("[PATCH 0/8] cpufreq: add generic cpufreq driver
support for Exynos5250/5800 platforms" https://lkml.org/lkml/2015/4/21/314)
also contains the detailed changelog.

However for part #3 (this one, "[PATCH 0/4] cpufreq: use generic cpufreq
drivers for Exynos5250 platform") such summary changelog got missed for
some reason.  Here it is:
- split Exynos5250 support from the original patch
- moved E5250_CPU_DIV[0,1]() macros to clk-exynos5250.c
- added CPU regulator supply property for Google Spring board
- removed exynos-cpufreq driver entirely as it is no longer used/needed

> version.  Also, on v12, I had several comments[1] and wonder if they've
> been addressed.

All issues previously reported should have been fixed.  If you still see
some problems please let me know.

[ I see now that exynos5420-arndale-octa.dts, exynos5420-peach-pit.dts,
  exynos5420-smdk5420.dts and exynos5800-peach-pi.dts should also have
  been updated to contain CPU cluster regulator supply properties or else
  if the default vdd_arm/vdd_kfc regulator state is set to too low value
  there may be problems with stability when switching to higher than
  default frequencies.  I have posted v2 version of patch #2/8 of part #4
  and pushed v2 combined branch on github.  Sorry for the inconvenience. ]

> Kevin
> 
> [1] http://article.gmane.org/gmane.linux.power-management.general/53494/match=patch+v12+0+6+use+generic+cpufreq

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
