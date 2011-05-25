From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 25 May 2011 11:11:37 -0700
Subject: [GIT PULL] Samsung S5P for 2.6.40 merge window
Message-ID: <4DDD4659.5050602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Please pull Samsung S5P updates from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

These things are for 2.6.40 and it includes removing ARCH_S5P6442. 
Actually there is no user now and if required will merge it into other 
ARCH like ARCH_S5P64X0 later.

As a note, I missed 'pull request' some fixes for s5p last -rc duration 
and I don't have it in my laptop. I'm out of office now :( so will send 
fixes after rc1.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 693d92a1bbc9e42681c42ed190bd42b636ca876f

   Linux 2.6.39-rc7

are available in the git repository at:
    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

Jaecheol Lee (1):
       ARM: EXYNOS4: CPUIDLE Support

Joonyoung Shim (2):
       ARM: EXYNOS4: Add Atmel mXT touchscreen device to the NURI board
       ARM: S3C64XX: Remove gpio-bank-X header files

Kukjin Kim (4):
       ARM: exynos4_defconfig: Update for adding machines
       ARM: S5P6442: Removing ARCH_S5P6442
       ASoC: Remove to support sound for S5P6442
       Merge branch 'dev/removing-s5p6442' into for-next

  Documentation/arm/Samsung/Overview.txt           |    2 -
  arch/arm/Kconfig                                 |   16 +-
  arch/arm/Makefile                                |    1 -
  arch/arm/common/Kconfig                          |    2 +-
  arch/arm/configs/exynos4_defconfig               |    2 +
  arch/arm/configs/s5p6442_defconfig               |   65 ----
  arch/arm/mach-exynos4/Kconfig                    |    2 +
  arch/arm/mach-exynos4/Makefile                   |    1 +
  arch/arm/mach-exynos4/cpuidle.c                  |   86 +++++
  arch/arm/mach-exynos4/mach-nuri.c                |   89 +++++
  arch/arm/mach-s3c64xx/dev-spi.c                  |   20 +-
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h |   48 ---
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h |   60 ---
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h |   53 ---
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h |   49 ---
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h |   44 ---
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h |   71 ----
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h |   42 ---
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h |   74 ----
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h |   40 --
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h |   36 --
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h |   54 ---
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h |   70 ----
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h |   69 ----
  arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h |   46 ---
  arch/arm/mach-s3c64xx/mach-smdk6410.c            |    1 -
  arch/arm/mach-s3c64xx/pm.c                       |   34 +-
  arch/arm/mach-s3c64xx/setup-i2c0.c               |    7 +-
  arch/arm/mach-s3c64xx/setup-i2c1.c               |    7 +-
  arch/arm/mach-s3c64xx/sleep.S                    |    8 +-
  arch/arm/mach-s5p6442/Kconfig                    |   25 --
  arch/arm/mach-s5p6442/Makefile                   |   24 --
  arch/arm/mach-s5p6442/Makefile.boot              |    2 -
  arch/arm/mach-s5p6442/clock.c                    |  420 
----------------------
  arch/arm/mach-s5p6442/cpu.c                      |  143 --------
  arch/arm/mach-s5p6442/dev-audio.c                |  217 -----------
  arch/arm/mach-s5p6442/dev-spi.c                  |  121 -------
  arch/arm/mach-s5p6442/clock.c                    |  420 
----------------------
  arch/arm/mach-s5p6442/cpu.c                      |  143 --------
  arch/arm/mach-s5p6442/dev-audio.c                |  217 -----------
  arch/arm/mach-s5p6442/dev-spi.c                  |  121 -------
  arch/arm/mach-s5p6442/dma.c                      |  105 ------
  arch/arm/mach-s5p6442/include/mach/debug-macro.S |   35 --
  arch/arm/mach-s5p6442/include/mach/dma.h         |   26 --
  arch/arm/mach-s5p6442/include/mach/entry-macro.S |   48 ---
  arch/arm/mach-s5p6442/include/mach/gpio.h        |  123 -------
  arch/arm/mach-s5p6442/include/mach/hardware.h    |   18 -
  arch/arm/mach-s5p6442/include/mach/io.h          |   17 -
  arch/arm/mach-s5p6442/include/mach/irqs.h        |   87 -----
  arch/arm/mach-s5p6442/include/mach/map.h         |   76 ----
  arch/arm/mach-s5p6442/include/mach/memory.h      |   19 -
  arch/arm/mach-s5p6442/include/mach/pwm-clock.h   |   70 ----
  arch/arm/mach-s5p6442/include/mach/regs-clock.h  |  104 ------
  arch/arm/mach-s5p6442/include/mach/regs-irq.h    |   19 -
  arch/arm/mach-s5p6442/include/mach/spi-clocks.h  |   17 -
  arch/arm/mach-s5p6442/include/mach/system.h      |   23 --
  arch/arm/mach-s5p6442/include/mach/tick.h        |   26 --
  arch/arm/mach-s5p6442/include/mach/timex.h       |   24 --
  arch/arm/mach-s5p6442/include/mach/uncompress.h  |   24 --
  arch/arm/mach-s5p6442/include/mach/vmalloc.h     |   17 -
  arch/arm/mach-s5p6442/init.c                     |   44 ---
  arch/arm/mach-s5p6442/mach-smdk6442.c            |  102 ------
  arch/arm/mach-s5p6442/setup-i2c0.c               |   28 --
  arch/arm/plat-s5p/Kconfig                        |    2 +-
  arch/arm/plat-s5p/cpu.c                          |   10 -
  arch/arm/plat-s5p/include/plat/s5p6442.h         |   33 --
  arch/arm/plat-samsung/include/plat/cpu.h         |    1 -
  arch/arm/plat-samsung/include/plat/debug-macro.S |    2 +-
  arch/arm/plat-samsung/include/plat/devs.h        |    6 -
  arch/arm/plat-samsung/include/plat/regs-serial.h |    2 +-
  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    1 -
  sound/soc/samsung/Kconfig                        |    4 +-
  sound/soc/samsung/smdk_wm8580.c                  |    2 +-
  69 files changed, 226 insertions(+), 2940 deletions(-)

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
