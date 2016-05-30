From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 May 2016 08:20:48 +0200
Subject: [GIT PULL] ARM: exynos: Fixes for v4.7
Message-ID: <1464589248-31326-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A couple of fixes from Arnd for this release cycle.


Best regards,
Krzysztof


The following changes since commit 2dcd0af568b0cf583645c8a317dd12e344b1c72a:

  Linux 4.6 (2016-05-15 15:43:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-4.7

for you to fetch changes up to 8a6f71ccb6c39ca5ae442d1478d3a076e2b1361e:

  ARM: exynos: don't select keyboard driver (2016-05-18 16:58:10 +0200)

----------------------------------------------------------------
Two fixes for v4.7 cycle for build issues:
1. Fix samsung-keypad build error if INPUT is selected as module.
   The error though depends on some uncommon build settings so it
   is not as easy to trigger.

2. Get rid of 'samsung_device_dma_mask' defined but not used warning.

----------------------------------------------------------------
Arnd Bergmann (2):
      ARM: samsung: improve static dma_mask definition
      ARM: exynos: don't select keyboard driver

 arch/arm/configs/exynos_defconfig   | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/mach-exynos/Kconfig        | 1 -
 arch/arm/plat-samsung/devs.c        | 2 +-
 4 files changed, 3 insertions(+), 2 deletions(-)
