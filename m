From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 13 Jun 2011 16:46:32 +0900
Subject: [GIT PULL] Samsung fixes for 3.0-rc3
Message-ID: <000001cc299e$07194550$154bcff0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull Samsung fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

These things are for bug fix on 3.0-rc3.
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


The following changes since commit 55922c9d1b84b89cb946c777fddccb3247e7df2c:

  Linux 3.0-rc1 (2011-05-29 17:43:36 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
s5p-fixes-for-linus

Heiko Stuebner (3):
      ARM: S3C24xx: Fix missing struct for s3c2410_dma_chan
      ARM: S3C24XX: Move s3c24xx_irq_syscore_ops to plat-s3c24xx/irq.c
      ARM: S3C2410: remove the now empty mach-s3c2410/irq.c

Jonghwan Choi (1):
      ARM: S5PV210: Fix possible null pointer dereference

Kukjin Kim (1):
      ARM: S5P: Should be S3C_VA_USB_HSPHY instead of S5P_VA_XX

Kyungmin Park (2):
      ARM: EXYNOS4: Remove compiler warning on exynos4_pwm4_resume
      ARM: SAMSUNG: Remove unused onenand plat functions

Padmavathi Venna (1):
      ARM: S5P64X0: Fix SPI platform device name

Tushar Behera (1):
      ARM: S5P: Fix compilation error for exynos4_defconfig

 arch/arm/mach-exynos4/Kconfig                      |    6 +++
 arch/arm/mach-exynos4/Makefile                     |    2 +-
 arch/arm/mach-exynos4/cpu.c                        |    2 +-
 arch/arm/mach-exynos4/include/mach/regs-usb-phy.h  |    2 +-
 .../mach-exynos4/{usb-phy.c => setup-usb-phy.c}    |    0
 arch/arm/mach-exynos4/time.c                       |    2 +
 arch/arm/mach-s3c2410/Makefile                     |    1 -
 arch/arm/mach-s3c2410/irq.c                        |   34
--------------------
 arch/arm/mach-s5pv210/cpufreq.c                    |    8 +++--
 arch/arm/plat-s3c24xx/dma.c                        |    2 +-
 arch/arm/plat-s3c24xx/irq.c                        |    6 +++
 arch/arm/plat-s5p/dev-onenand.c                    |   12 -------
 arch/arm/plat-s5p/include/plat/map-s5p.h           |    2 +-
 arch/arm/plat-samsung/dev-onenand.c                |   12 -------
 arch/arm/plat-samsung/include/plat/devs.h          |    6 +--
 15 files changed, 26 insertions(+), 71 deletions(-)
