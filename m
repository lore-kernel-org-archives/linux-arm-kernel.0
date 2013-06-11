From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Jun 2013 06:08:48 +0900
Subject: [GIT PULL 3/6] exynos arch
Message-ID: <51B791E0.5040104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-arch-1

for you to fetch changes up to d75666024bbb7d1b4fa6f0b00ecd8d834033259a:

   ARM: EXYNOS: call scu_enable() only in case of cortex-A9 processor 
(2013-06-10 18:28:04 +0900)

----------------------------------------------------------------
update exynos arch part

----------------------------------------------------------------
Doug Anderson (1):
       ARM: EXYNOS: Select PINCTRL_EXYNOS for exynos4/5 at chip level

Girish K S (1):
       ARM: EXYNOS: force MAC ip to 32bit DMA

Kukjin Kim (1):
       ARM: EXYNOS: no more support non-DT for EXYNOS SoCs

Leela Krishna Amudala (1):
       ARM: EXYNOS: call scu_enable() only in case of cortex-A9 processor

Thomas Abraham (1):
       ARM: EXYNOS: Add a platform bus notifier to set dma masks for 
Exynos5440

Vivek Gautam (1):
       ARM: EXYNOS: Enable XHCI support on exynos5

  arch/arm/mach-exynos/Kconfig           | 330 
+--------------------------------
  arch/arm/mach-exynos/Makefile          |  26 ---
  arch/arm/mach-exynos/common.c          |  10 -
  arch/arm/mach-exynos/dev-ahci.c        | 255 -------------------------
  arch/arm/mach-exynos/dev-ohci.c        |  52 ------
  arch/arm/mach-exynos/dma.c             | 322 
--------------------------------
  arch/arm/mach-exynos/mach-exynos5-dt.c |  28 +++
  arch/arm/mach-exynos/platsmp.c         |   2 +-
  arch/arm/mach-exynos/pm_domains.c      |   7 -
  drivers/pinctrl/Kconfig                |   5 +-
  10 files changed, 40 insertions(+), 997 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/dev-ahci.c
  delete mode 100644 arch/arm/mach-exynos/dev-ohci.c
  delete mode 100644 arch/arm/mach-exynos/dma.c
