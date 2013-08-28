From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Aug 2013 09:58:52 +0900
Subject: [GIT PULL 1/2] 3rd Round Samsung common clk s3c64xx for v3.12
Message-ID: <235101cea389$c3c83cd0$4b58b670$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

  Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-clk-s3c64xx

for you to fetch changes up to 1ca2dad9588ac09310154a480f8f9cf400760a31:

  Merge branch 'clk-next-s3c64xx-delta' into v3.12-next/common-clk-s3c64xx
(2013-08-28 01:03:31 +0900)

----------------------------------------------------------------

Common clk support for S3C64XX
- add PLL for S3C64XX
- add s3c64xx clock driver
- update drivers to use CCF of s3c64xx

Based on Samsung PWM support cleanup
- merged tags/v3.12-pwm-cleanup-for-olof

Regarding clk patches from Mike's clk tree
- based on Mike's clk-next-s3c64xx
- and merged Mikes' clk-next-s3c64xx-delta

----------------------------------------------------------------
Kukjin Kim (2):
      Merge tag 'v3.12-pwm-cleanup-for-olof' of git://github.com/tom3q/linux
into v3.12-next/common-clk-s3c64xx
      Merge branch 'clk-next-s3c64xx-delta' into
v3.12-next/common-clk-s3c64xx

Mike Turquette (1):
      Merge branch 'clk-next-s3c64xx' into clk-next

Peter Meerwald (1):
      clk: fix typos

Rahul Sharma (2):
      clk/exynos5250: add mout_hdmi mux clock for hdmi
      clk/exynos5250: add sclk_hdmiphy in the list of special clocks

Sachin Kamat (11):
      of/documentation: Fix a typo in exynos5250-clock.txt
      clk: exynos4: Staticize local symbols
      clk: exynos4: Remove unused function
      clk: exynos5250: Staticize local symbols
      clk: exynos5420: Staticize local symbols
      clk: exynos5440: Staticize local symbols
      clk: exynos-audss: Staticize exynos_audss_clk_init
      clk: exynos5250: Add G2D gate clock
      clk: exynos4: Add clock entries for TMU
      of/documentation: Update G2D documentation
      Documentation: clk: Fix a trivial typo in audss

Tomasz Figa (29):
      clk: mux: Add support for read-only muxes.
      clk: samsung: pll: Add support for PLL6552 and PLL6553
      clk: samsung: Add clock driver for S3C64xx SoCs
      clocksource: samsung_pwm_timer: Do not request PWM mem region
      clocksource: samsung_pwm_timer: Correct definition of AUTORELOAD bit
      clocksource: samsung_pwm_timer: Cache clocksource register address
      clocksource: samsung_pwm_timer: Do not use clocksource_mmio
      clocksource: samsung_pwm_timer: Handle suspend/resume correctly
      ARM: SAMSUNG: Unify base address definitions of timer block
      ARM: SAMSUNG: Add new PWM platform device
      ARM: SAMSUNG: Set PWM platform data
      ARM: SAMSUNG: Move all platforms to new clocksource driver
      ARM: SAMSUNG: Remove old samsung-time driver
      ARM: SAMSUNG: Remove unused PWM timer IRQ chip code
      pwm: samsung: Rename to pwm-samsung-legacy
      pwm: Add new pwm-samsung driver
      ARM: SAMSUNG: Rework private data handling in dev-backlight
      ARM: SAMSUNG: Modify board files to use new PWM platform device
      pwm: Remove superseded pwm-samsung-legacy driver
      ARM: SAMSUNG: Remove old PWM timer platform devices
      ARM: SAMSUNG: Remove pwm-clock infrastructure
      ARM: SAMSUNG: Remove remaining uses of plat/regs-timer.h header
      ARM: SAMSUNG: Remove plat/regs-timer.h header
      ARM: SAMSUNG: Add soc_is_s3c6400/s3c6410 macros
      ARM: S3C64XX: Use clk_prepare_enable/clk_disable_unprepare in dma.c
      usb: ohci-s3c2410.c: Use clk_prepare_enable/clk_disable_unprepare
      ARM: S3C64XX: Migrate clock handling to Common Clock Framework
      ARM: S3C64XX: Remove old clock management code
      clk: samsung: pll: Use new registration method for PLL6552 and PLL6553

Tushar Behera (1):
      Documentation: exynos5250-clock: Add div_i2s1 and div_i2s2

Vikas Sajjan (3):
      clk: samsung: Add set_rate() clk_ops for PLL36xx
      clk: samsung: Reorder MUX registration for mout_vpllsrc
      clk: samsung: Add EPLL and VPLL freq table for exynos5250 SoC

Yadwinder Singh Brar (8):
      clk: samsung: Introduce a common samsung_clk_pll struct
      clk: samsung: Define a common samsung_clk_register_pll()
      clk: samsung: Migrate exynos5250 to use common
samsung_clk_register_pll()
      clk: samsung: Migrate exynos4 to use common samsung_clk_register_pll()
      clk: samsung: Migrate exynos5420 to use common
samsung_clk_register_pll()
      clk: samsung: Remove unused pll registeration code for pll35xx and
pll36xx
      clk: samsung: Add support to register rate_table for samsung plls
      clk: samsung: Add set_rate() clk_ops for PLL35xx

 .../devicetree/bindings/clock/clk-exynos-audss.txt |    2 +-
 .../devicetree/bindings/clock/exynos4-clock.txt    |    1 +
 .../devicetree/bindings/clock/exynos5250-clock.txt |   14 +-
 .../bindings/clock/samsung,s3c64xx-clock.txt       |   77 ++
 .../devicetree/bindings/gpu/samsung-g2d.txt        |    7 +-
 arch/arm/Kconfig                                   |   13 +-
 arch/arm/mach-s3c24xx/Kconfig                      |    6 -
 arch/arm/mach-s3c24xx/clock-s3c2410.c              |    1 -
 arch/arm/mach-s3c24xx/clock-s3c2412.c              |    1 -
 arch/arm/mach-s3c24xx/clock-s3c2416.c              |    2 -
 arch/arm/mach-s3c24xx/clock-s3c2443.c              |    2 -
 arch/arm/mach-s3c24xx/common.c                     |   27 +
 arch/arm/mach-s3c24xx/include/mach/map.h           |    2 +
 arch/arm/mach-s3c24xx/mach-h1940.c                 |    4 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |    5 +-
 arch/arm/mach-s3c64xx/Kconfig                      |    2 -
 arch/arm/mach-s3c64xx/Makefile                     |    2 +-
 arch/arm/mach-s3c64xx/clock.c                      | 1009
--------------------
 arch/arm/mach-s3c64xx/common.c                     |   53 +-
 arch/arm/mach-s3c64xx/common.h                     |   12 +-
 arch/arm/mach-s3c64xx/dma.c                        |    4 +-
 arch/arm/mach-s3c64xx/include/mach/irqs.h          |    8 -
 arch/arm/mach-s3c64xx/include/mach/map.h           |    1 +
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h    |  132 +--
 arch/arm/mach-s3c64xx/irq-pm.c                     |    2 -
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    6 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    6 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |   15 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    7 +-
 arch/arm/mach-s3c64xx/pm.c                         |   21 -
 arch/arm/mach-s3c64xx/s3c6400.c                    |    6 -
 arch/arm/mach-s3c64xx/s3c6410.c                    |    7 -
 arch/arm/mach-s5p64x0/Kconfig                      |    2 -
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |    2 -
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |    2 -
 arch/arm/mach-s5p64x0/common.c                     |   27 +
 arch/arm/mach-s5p64x0/include/mach/irqs.h          |    2 -
 arch/arm/mach-s5p64x0/include/mach/map.h           |    1 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    5 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    5 +-
 arch/arm/mach-s5p64x0/pm.c                         |    3 -
 arch/arm/mach-s5pc100/Kconfig                      |    1 -
 arch/arm/mach-s5pc100/clock.c                      |    2 -
 arch/arm/mach-s5pc100/common.c                     |   28 +
 arch/arm/mach-s5pc100/include/mach/irqs.h          |    2 -
 arch/arm/mach-s5pc100/include/mach/map.h           |    1 +
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    5 +-
 arch/arm/mach-s5pv210/Kconfig                      |    1 -
 arch/arm/mach-s5pv210/clock.c                      |    1 -
 arch/arm/mach-s5pv210/common.c                     |   28 +
 arch/arm/mach-s5pv210/include/mach/irqs.h          |    2 -
 arch/arm/mach-s5pv210/include/mach/map.h           |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    5 +-
 arch/arm/mach-s5pv210/pm.c                         |   10 -
 arch/arm/plat-samsung/Kconfig                      |   14 -
 arch/arm/plat-samsung/Makefile                     |    3 -
 arch/arm/plat-samsung/dev-backlight.c              |   61 +-
 arch/arm/plat-samsung/devs.c                       |   42 +-
 arch/arm/plat-samsung/include/plat/clock.h         |    4 -
 arch/arm/plat-samsung/include/plat/cpu.h           |    4 +
 arch/arm/plat-samsung/include/plat/devs.h          |    1 +
 arch/arm/plat-samsung/include/plat/irq-vic-timer.h |   13 -
 arch/arm/plat-samsung/include/plat/irqs.h          |    9 -
 arch/arm/plat-samsung/include/plat/pwm-clock.h     |   81 --
 arch/arm/plat-samsung/include/plat/pwm-core.h      |   22 +
 arch/arm/plat-samsung/include/plat/regs-timer.h    |  124 ---
 arch/arm/plat-samsung/include/plat/samsung-time.h  |   23 -
 arch/arm/plat-samsung/irq-vic-timer.c              |   98 --
 arch/arm/plat-samsung/pwm-clock.c                  |  474 ---------
 arch/arm/plat-samsung/s5p-irq.c                    |    4 -
 arch/arm/plat-samsung/samsung-time.c               |  394 --------
 drivers/clk/Kconfig                                |    2 +-
 drivers/clk/clk-mux.c                              |   10 +-
 drivers/clk/clk.c                                  |   13 +-
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos-audss.c             |    2 +-
 drivers/clk/samsung/clk-exynos4.c                  |   86 +-
 drivers/clk/samsung/clk-exynos5250.c               |  129 ++-
 drivers/clk/samsung/clk-exynos5420.c               |  100 +-
 drivers/clk/samsung/clk-exynos5440.c               |   14 +-
 drivers/clk/samsung/clk-pll.c                      |  416 ++++++--
 drivers/clk/samsung/clk-pll.h                      |   40 +-
 drivers/clk/samsung/clk-s3c64xx.c                  |  473 +++++++++
 drivers/clk/samsung/clk.h                          |   53 +
 drivers/clocksource/Kconfig                        |    1 -
 drivers/clocksource/samsung_pwm_timer.c            |  108 ++-
 drivers/pwm/pwm-samsung.c                          |  709 +++++++++-----
 drivers/usb/host/ohci-s3c2410.c                    |    8 +-
 include/clocksource/samsung_pwm.h                  |    7 +
 include/dt-bindings/clock/samsung,s3c64xx-clock.h  |  178 ++++
 include/linux/clk-provider.h                       |    2 +
 95 files changed, 2256 insertions(+), 3068 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/clock/samsung,s3c64xx-clock.txt
 delete mode 100644 arch/arm/mach-s3c64xx/clock.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/pwm-clock.h
 create mode 100644 arch/arm/plat-samsung/include/plat/pwm-core.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-timer.h
 delete mode 100644 arch/arm/plat-samsung/irq-vic-timer.c
 delete mode 100644 arch/arm/plat-samsung/pwm-clock.c
 delete mode 100644 arch/arm/plat-samsung/samsung-time.c
 create mode 100644 drivers/clk/samsung/clk-s3c64xx.c
 create mode 100644 include/dt-bindings/clock/samsung,s3c64xx-clock.h
