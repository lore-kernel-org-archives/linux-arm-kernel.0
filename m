From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 16 Dec 2013 18:24:33 +0100
Subject: [GIT PULL 1/7] Samsung fixes for v3.14
In-Reply-To: <52AE0F41.7050706@samsung.com>
References: <52AE0F41.7050706@samsung.com>
Message-ID: <3351204.WyoCcrrZ3X@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Monday 16 of December 2013 05:21:21 Kukjin Kim wrote:
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>    Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/samsung-fixes
> 
> for you to fetch changes up to 236940d2c951a84735fdd7b958b5159eaf501784:
> 
>    ARM: dts: Update display clock frequency for Origen-4412 (2013-12-16 
> 04:41:57 +0900)
> 
> ----------------------------------------------------------------
> Samsung non-critical fixes for v3.14
> - Switch FIFO mode for arch_enable_uart_fifo()
> - Add missing op_mode for PMIC on exynos5250-arndale
> - Add missing clock-frequency for CPU on exynos5250
> - Fix typo samaung to samsung for exynos5420-pinctrl
> - Fix display clock-frequency for exynos4210/exynos4412-origen
> 
> ----------------------------------------------------------------
> Alexander Shiyan (1):
>        ARM: SAMSUNG: Fix switching FIFO in arch_enable_uart_fifo function
> 
> Sachin Kamat (4):
>        ARM: dts: Add missing op_mode property to PMIC on Arndale
>        ARM: dts: Add missing frequency property to exynos5250
>        ARM: dts: Fix a typo in exynos5420-pinctrl.dtsi
>        ARM: dts: Update display clock frequency for Origen-4412
> 
> Tushar Behera (1):
>        ARM: dts: Update display clock frequency for Origen-4210
> 
>   arch/arm/boot/dts/exynos4210-origen.dts         | 2 +-
>   arch/arm/boot/dts/exynos4412-origen.dts         | 2 +-
>   arch/arm/boot/dts/exynos5250-arndale.dts        | 2 ++
>   arch/arm/boot/dts/exynos5250.dtsi               | 2 ++
>   arch/arm/boot/dts/exynos5420-pinctrl.dtsi       | 2 +-
>   arch/arm/plat-samsung/include/plat/uncompress.h | 2 ++
>   6 files changed, 9 insertions(+), 3 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I've sent a patch to fix up MMC0 on mini6410 board, when using board file
to boot the system:

[PATCH] ARM: s3c64xx: mini6410: Correct card detect type for HSMMC1

Could we get this patch merged?

I know we are moving to DT, but until all boards get converted, board
files must be supported too and this bug makes it impossible to test
non-DT s3c64xx support on Mini6410, without extra out of tree patches.

Best regards,
Tomasz
