From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 23 Aug 2012 20:06:35 +0900
Subject: [GIT PULL] Samsung fixes for v3.6
Message-ID: <1d5f01cd811f$5c5de8c0$1519ba40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are Samsung fixes for v3.6

For HDMI, already HDMI support for EXYNOS in mainline kernel is broken
because its configuration moved to platform data but regarding platform data
didn't support yet. And others are for fix warnings.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.6-samsung-fixes-1

Heiko Stuebner (2):
      ARM: S3C24XX: Add missing DMACH_DT_PROP
      ARM: S3C24XX: Fix s3c2410_dma_enqueue parameters

Sachin Kamat (3):
      ARM: Samsung: Make uart_save static in pm.c file
      ARM: SAMSUNG: Set HDMI platform data for Exynos4x12 SoCs
      ARM: EXYNOS: Set HDMI platform data in SMDKV310

Tushar Behera (2):
      ARM: SAMSUNG: Add API to set platform data for s5p-tv driver
      ARM: EXYNOS: Set HDMI platform data in Origen board

 arch/arm/mach-exynos/mach-origen.c        |    7 +++++++
 arch/arm/mach-exynos/mach-smdkv310.c      |    7 +++++++
 arch/arm/mach-s3c24xx/include/mach/dma.h  |    3 ++-
 arch/arm/plat-s3c24xx/dma.c               |    2 +-
 arch/arm/plat-samsung/devs.c              |   29
++++++++++++++++++++++++++++-
 arch/arm/plat-samsung/include/plat/hdmi.h |   16 ++++++++++++++++
 arch/arm/plat-samsung/pm.c                |    2 +-
 7 files changed, 62 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/hdmi.h
