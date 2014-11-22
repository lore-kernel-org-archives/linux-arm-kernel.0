From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 22 Nov 2014 11:27:09 +0900
Subject: [PATCH v5] ARM: EXYNOS: add Exynos3250 PMU support
In-Reply-To: <4728982.ETBlJctOKU@amdc1032>
References: <4728982.ETBlJctOKU@amdc1032>
Message-ID: <02fb01d005fb$d105c1d0$73114570$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartlomiej Zolnierkiewicz wrote:
> 
> This patch prepares the PMU code for the future:
> - suspend/resume (S2R) support
> - cpuidle AFTR/W-AFTR modes support
> on Exynos3250.
> 
> Cc: Vikas Sajjan <vikas.sajjan@samsung.com>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v5:
> - added Reviewed-by tag from Pankaj Dubey
> - fixed form -> from typo
> 
> v4:
> - rebased on top of next-20141114 branch of linux-next kernel tree
>   (it also applies fine to for-next branch of linux-samsung.git)
> - removed writing to undocumented CORE2 and CORE3 related registers
> - fixed values used for EXYNOS3_[G3D,LCD]_SYS_PWR_REG registers
> - added defines for values used for EXYNOS3_*_DURATION registers
> - removed redundat pr_info("EXYNOS3250 PMU Initialize\n")
> 
> v3:
> - rebased on top of for-next branch of linux-samsung.git and
>   [PATCH v7] mfd: syscon: Decouple syscon interface from platform devices
>   (https://lkml.org/lkml/2014/9/30/156)
>   [PATCH v9 0/2] ARM: Exynos: Convert PMU implementation into a platform driver
>   (https://lkml.org/lkml/2014/10/6/89)
>   [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
>   (http://www.spinics.net/lists/arm-kernel/msg368207.html)
> 
> v2:
> - rebased on top of next-20140708 and
>   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32410.html
>   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33660.html
>   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33675.html
> 
>   this patch also applies fine after/before Exynos5800 PMU support:
>   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33835.html
> 
>  arch/arm/mach-exynos/pmu.c      | 167 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h | 128 ++++++++++++++++++++++++++++++
>  2 files changed, 295 insertions(+)

Looks good to me, I think each SoC specific pm features would be handled in
each file like cpufreq though...maybe next time? :-)

BTW, I need to sort out pmu related changes from Pankaj, Amit and you. If
anything is required, I'll let you know.

Thanks,
Kukjin
