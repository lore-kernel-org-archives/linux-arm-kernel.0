From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 20:38:30 +0900
Subject: [PATCH] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
In-Reply-To: <2f3001ce3515$9a9ae1b0$cfd0a510$%kim@samsung.com>
References: <2f3001ce3515$9a9ae1b0$cfd0a510$%kim@samsung.com>
Message-ID: <2f3701ce3516$c29aca80$47d05f80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> 
> As we discussed in mailing list, non-DT for EXYNOS SoCs will not be
> supported from v3.10. This patch removes regarding files for non-DT
> including board files.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/configs/exynos4_defconfig         |   68 --
>  arch/arm/mach-exynos/Kconfig               |  303 +-----
>  arch/arm/mach-exynos/Makefile              |   26 -
>  arch/arm/mach-exynos/common.c              |    9 +-
>  arch/arm/mach-exynos/dev-ahci.c            |  255 -----
>  arch/arm/mach-exynos/dev-ohci.c            |   52 --
>  arch/arm/mach-exynos/dma.c                 |  322 -------
>  arch/arm/mach-exynos/mach-armlex4210.c     |  206 -----
>  arch/arm/mach-exynos/mach-nuri.c           | 1387
> ----------------------------
>  arch/arm/mach-exynos/mach-origen.c         |  822 -----------------
>  arch/arm/mach-exynos/mach-smdk4x12.c       |  395 --------
>  arch/arm/mach-exynos/mach-smdkv310.c       |  443 ---------
>  arch/arm/mach-exynos/mach-universal_c210.c | 1159 -----------------------
>  arch/arm/mach-exynos/pm_domains.c          |    7 -
>  arch/arm/mach-exynos/setup-fimc.c          |   44 -
>  arch/arm/mach-exynos/setup-fimd0.c         |   43 -
>  arch/arm/mach-exynos/setup-i2c1.c          |   23 -
>  arch/arm/mach-exynos/setup-i2c2.c          |   23 -
>  arch/arm/mach-exynos/setup-i2c3.c          |   23 -
>  arch/arm/mach-exynos/setup-i2c4.c          |   23 -
>  arch/arm/mach-exynos/setup-i2c5.c          |   23 -
>  arch/arm/mach-exynos/setup-i2c6.c          |   23 -
>  arch/arm/mach-exynos/setup-i2c7.c          |   23 -
>  arch/arm/mach-exynos/setup-keypad.c        |   36 -
>  arch/arm/mach-exynos/setup-sdhci-gpio.c    |  152 ---
>  arch/arm/mach-exynos/setup-spi.c           |   45 -
>  arch/arm/mach-exynos/setup-usb-phy.c       |  223 -----
>  27 files changed, 3 insertions(+), 6155 deletions(-)
>  delete mode 100644 arch/arm/configs/exynos4_defconfig
>  delete mode 100644 arch/arm/mach-exynos/dev-ahci.c
>  delete mode 100644 arch/arm/mach-exynos/dev-ohci.c
>  delete mode 100644 arch/arm/mach-exynos/dma.c
>  delete mode 100644 arch/arm/mach-exynos/mach-armlex4210.c
>  delete mode 100644 arch/arm/mach-exynos/mach-nuri.c
>  delete mode 100644 arch/arm/mach-exynos/mach-origen.c
>  delete mode 100644 arch/arm/mach-exynos/mach-smdk4x12.c
>  delete mode 100644 arch/arm/mach-exynos/mach-smdkv310.c
>  delete mode 100644 arch/arm/mach-exynos/mach-universal_c210.c
>  delete mode 100644 arch/arm/mach-exynos/setup-fimc.c
>  delete mode 100644 arch/arm/mach-exynos/setup-fimd0.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c1.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c2.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c3.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c4.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c5.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c6.c
>  delete mode 100644 arch/arm/mach-exynos/setup-i2c7.c
>  delete mode 100644 arch/arm/mach-exynos/setup-keypad.c
>  delete mode 100644 arch/arm/mach-exynos/setup-sdhci-gpio.c
>  delete mode 100644 arch/arm/mach-exynos/setup-spi.c
>  delete mode 100644 arch/arm/mach-exynos/setup-usb-phy.c
> 
One more, as you know, we cannot support all features non-DT did only with
DT exynos. But I think, if required, some of them can be kept in samsung
tree temporarily.

Note, original patch couldn't submitted to linux arm kernel ml due to size.
And please ignore useless line wrapped due to e-mail client problem :-(

Thanks.

- Kukjin

[...]
