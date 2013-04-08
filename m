From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:18:42 +0900
Subject: [GIT PULL 04/10] clk-exynos for v3.10
Message-ID: <51630A02.4080905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/clk-exynos-for-v3.10

for you to fetch changes up to da821eb7d42935b0f7056d98c75fd1150f6636f4:

   Merge commit 'v3.9-rc5' into next/clk-exynos (2013-04-09 01:10:13 +0900)

----------------------------------------------------------------

add suppport common clock framework for exynos

----------------------------------------------------------------
Abhilash Kesavan (1):
       ARM: dts: Add max77686 device tree support for CROS5250

Andrzej Hajda (1):
       clk: exynos4: Add missing CMU_TOP and ISP clocks

Dongjin Kim (3):
       ARM: dts: Add board dts file for ODROID-X
       ARM: dts: Fix the timing property of MSHC controller for 
exynos4412-odroidx
       ARM: dts: enable RTC device node for exynos4412-odroidx

Giridhar Maruthy (3):
       ARM: dts: remove disabled status from watchdog node for 
exynos5440-ssdk5440
       ARM: dts: remove disabled status from RTC node for 
exynos5440-ssdk5440
       ARM: dts: change compatible value for exynos5440 i2c

Girish K S (1):
       ARM: dts: Add initial board support file for exynos5250-arndale

Heiko Stueber (1):
       clk: samsung: fix pm init on non-dt platforms

Heiko Stuebner (6):
       ARM: S3C24XX: remove plat/irq.h in plat-samsung
       ARM: S3C24XX: move plat-samsung/s3c24XX headers to local common.h
       ARM: S3C24XX: cleanup the included soc init functions in common.h
       clk: samsung: register clk_div_tables for divider clocks
       clk: samsung: always allocate the clk_table
       clk: samsung: add infrastructure to add separate aliases

Jingoo Han (2):
       ARM: EXYNOS: Add AUXDATA for DP controller
       ARM: dts: Add device tree node for DP controller for exynos5250

Kukjin Kim (7):
       mmc: s3cmci: moved mach/regs-sdi.h into s3cmci device driver
       ARM: S3C24XX: plat/common-smdk.h local
       ARM: dts: cleanup exynos5440.dtsi
       ARM: dts: re-organized cpu node for exynos5440
       Merge branch 'next/timer-samsung' into next/clk-exynos
       Merge branch 'next/mct-exynos' into next/clk-exynos
       Merge commit 'v3.9-rc5' into next/clk-exynos

Leela Krishna Amudala (1):
       clk: exynos5250: register display block gate clocks to common 
clock framework

Lukasz Majewski (1):
       clk: exynos4: Export clocks used by exynos cpufreq drivers

Prasanna Kumar (1):
       ARM: dts: Set up power domain for MFC and G-scaler for exynos5250

Romain Naour (5):
       ARM: SAMSUNG: Rename s5p-time to samsung-time
       ARM: S3C24XX: Add samsung-time support for s3c24xx
       ARM: S3C64XX: Add samsung-time support for s3c64xx
       ARM: S5PC100: Add samsung-time support for s5pc100
       ARM: SAMSUNG: Remove unused plat-samsung/time.c

Sachin Kamat (12):
       ARM: dts: Add vmmc regulator node in exynos4412-origen.dts
       ARM: dts: Add sdhci node for exynos4412-origen
       ARM: dts: Update MFC DT binding documentation
       ARM: dts: Add MFC codec support for EXYNOS4 DT machines
       ARM: dts: Add MFC codec support to SMDKV310 DT
       ARM: dts: Add MFC codec support to Origen DT
       ARM: dts: Add MFC codec entry to exynos4412-origen DT
       ARM: dts: Add MFC codec entry to exynos4412-smdk4412 DT
       ARM: dts: Add MSHC node for exynos4412-origen DT
       ARM: dts: Add s5m8767 PMIC node to exynos4412-origen DT
       ARM: dts: Add sdhci node for exynos4412-smdk4412
       clk: samsung: Fix compilation error

Sylwester Nawrocki (3):
       clk: exynos4: Correct sclk_mfc clock definition
       clk: exynos4: Add camera related clock definitions
       clk: exynos4: export clocks required for fimc-is

Thomas Abraham (25):
       ARM: dts: add board dts file for EXYNOS4412 based Origen board
       ARM: EXYNOS: add a register base address variable in mct 
controller driver
       ARM: EXYNOS: prepare an array of MCT interrupt numbers and use it
       ARM: EXYNOS: add device tree support for MCT controller driver
       ARM: EXYNOS: allow dt based discovery of mct controller using 
clocksource_of_init
       ARM: dts: add mct device tree node for all supported Exynos SoC's
       ARM: EXYNOS: remove static io-remapping of mct registers for Exynos5
       ARM: EXYNOS: move mct driver to drivers/clocksource
       clk: samsung: add common clock framework helper functions for 
Samsung platforms
       clk: samsung: add pll clock registration helper functions
       clk: exynos4: register clocks using common clock framework
       clk: exynos5250: register clocks using common clock framework
       clk: exynos5440: register clocks using common clock framework
       ARM: EXYNOS: Migrate clock support to common clock framework
       ARM: EXYNOS: Initialize the clocks prior to timer initialization
       ARM: EXYNOS: allow legacy board support to specify xxti and 
xusbxti clock speed
       ARM: EXYNOS: remove auxdata table from exynos4/5 dt machine file
       clocksource: mct: use fin_pll clock as the tick clock source for mct
       clocksource: mct: add support for mct clock setup
       ARM: dts: add Exynos4 and Exynos5 clock controller nodes
       ARM: dts: add clock provider information for all controllers in 
Exynos4 SoCs
       ARM: dts: add clock provider information for all controllers in 
Exynos5250 SoC
       ARM: dts: add clock provider information for all controllers in 
Exynos5440 SoC
       ARM: dts: add board specific fixed rate clock nodes for Exynos 
based platforms
       ARM: EXYNOS: fix compilation error introduced due to common clock 
migration

Tomasz Figa (17):
       clk: exynos4: Use mout_mpll_user_* on Exynos4x12
       clk: exynos4: Add missing mout_mipihsi clock
       clk: exynos4: Add missing sclk_audio0 clock
       clk: exynos4: Export sclk_pcm0
       clk: exynos4: Move dac and mixer to Exynos4210-specific clocks
       clk: samsung: Remove unimplemented ops for pll
       clk: exynos4: Export mout_core clock of Exynos4210
       clk: exynos4: Add G3D clocks
       clk: exynos4: Add missing mout_sata on Exynos4210
       clk: exynos4: Define {E,V}PLL registers
       clk: exynos4: Use SRC_MASK_PERIL{0,1} definitions
       clk: exynos4: Remove SoC-specific registers from save list
       clk: exynos4: Add E4210 prefix to LCD1 clock registers
       clk: exynos4: Add E4210 prefix to GATE_IP_PERIR register
       clk: exynos4: Remove E4X12 prefix from SRC_DMC register
       clk: exynos4: Add missing registers to suspend save list
       clk: exynos4: Add support for SoC-specific register save list

Tushar Behera (1):
       clk: exynos5250: Fix divider values for sclk_mmc{0,1,2,3}

Vivek Gautam (2):
       ARM: dts: Enabling ehci-s5p driver for EXYNOS5250
       ARM: dts: Enabling ohci-exynos driver for EXYNOS5250

  .../devicetree/bindings/clock/exynos4-clock.txt    |  288 ++++
  .../devicetree/bindings/clock/exynos5250-clock.txt |  177 +++
  .../devicetree/bindings/clock/exynos5440-clock.txt |   61 +
  .../devicetree/bindings/media/s5p-mfc.txt          |   21 +
  .../bindings/timer/samsung,exynos4210-mct.txt      |   68 +
  .../devicetree/bindings/usb/exynos-usb.txt         |   40 +
  arch/arm/Kconfig                                   |   14 +-
  arch/arm/boot/dts/Makefile                         |    3 +
  arch/arm/boot/dts/cros5250-common.dtsi             |  138 ++
  arch/arm/boot/dts/exynos4.dtsi                     |   58 +
  arch/arm/boot/dts/exynos4210-origen.dts            |   18 +
  arch/arm/boot/dts/exynos4210-smdkv310.dts          |   18 +
  arch/arm/boot/dts/exynos4210-trats.dts             |   12 +
  arch/arm/boot/dts/exynos4210.dtsi                  |   30 +
  arch/arm/boot/dts/exynos4212.dtsi                  |   22 +
  arch/arm/boot/dts/exynos4412-odroidx.dts           |  109 ++
  arch/arm/boot/dts/exynos4412-origen.dts            |  430 +++++
  arch/arm/boot/dts/exynos4412-smdk4412.dts          |   25 +
  arch/arm/boot/dts/exynos4412.dtsi                  |   26 +
  arch/arm/boot/dts/exynos4x12.dtsi                  |    6 +
  arch/arm/boot/dts/exynos5250-arndale.dts           |  129 ++
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   20 +
  arch/arm/boot/dts/exynos5250-snow.dts              |   11 +
  arch/arm/boot/dts/exynos5250.dtsi                  |  142 ++
  arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   19 +-
  arch/arm/boot/dts/exynos5440.dtsi                  |   66 +-
  arch/arm/mach-exynos/Kconfig                       |   12 +-
  arch/arm/mach-exynos/Makefile                      |    6 -
  arch/arm/mach-exynos/clock-exynos4.c               | 1601 
-------------------
  arch/arm/mach-exynos/clock-exynos4.h               |   35 -
  arch/arm/mach-exynos/clock-exynos4210.c            |  187 ---
  arch/arm/mach-exynos/clock-exynos4212.c            |  201 ---
  arch/arm/mach-exynos/clock-exynos5.c               | 1645 
--------------------
  arch/arm/mach-exynos/common.c                      |   59 +-
  arch/arm/mach-exynos/common.h                      |   10 +-
  arch/arm/mach-exynos/include/mach/irqs.h           |    6 -
  arch/arm/mach-exynos/include/mach/map.h            |    1 -
  arch/arm/mach-exynos/include/mach/regs-clock.h     |  107 --
  arch/arm/mach-exynos/include/mach/regs-mct.h       |   53 -
  arch/arm/mach-exynos/mach-armlex4210.c             |    3 +-
  arch/arm/mach-exynos/mach-exynos4-dt.c             |  122 +-
  arch/arm/mach-exynos/mach-exynos5-dt.c             |  141 +-
  arch/arm/mach-exynos/mach-nuri.c                   |    5 +-
  arch/arm/mach-exynos/mach-origen.c                 |    5 +-
  arch/arm/mach-exynos/mach-smdk4x12.c               |    5 +-
  arch/arm/mach-exynos/mach-smdkv310.c               |    7 +-
  arch/arm/mach-exynos/mach-universal_c210.c         |    9 +-
  arch/arm/mach-s3c24xx/Kconfig                      |    6 +
  arch/arm/mach-s3c24xx/bast-irq.c                   |    2 -
  arch/arm/mach-s3c24xx/clock-s3c2410.c              |    1 -
  arch/arm/mach-s3c24xx/clock-s3c2412.c              |    1 -
  arch/arm/mach-s3c24xx/clock-s3c2416.c              |    1 -
  arch/arm/mach-s3c24xx/clock-s3c2443.c              |    1 -
  arch/arm/mach-s3c24xx/common-smdk.c                |    3 +-
  .../include/plat => mach-s3c24xx}/common-smdk.h    |    3 +-
  arch/arm/mach-s3c24xx/common.c                     |    7 +-
  arch/arm/mach-s3c24xx/common.h                     |   90 +-
  arch/arm/mach-s3c24xx/dma-s3c2410.c                |    1 -
  arch/arm/mach-s3c24xx/dma-s3c2412.c                |    1 -
  arch/arm/mach-s3c24xx/dma-s3c2440.c                |    1 -
  arch/arm/mach-s3c24xx/dma-s3c2443.c                |    1 -
  arch/arm/mach-s3c24xx/include/mach/regs-sdi.h      |  127 --
  arch/arm/mach-s3c24xx/irq-pm.c                     |    7 +-
  arch/arm/mach-s3c24xx/irq.c                        |    8 +-
  arch/arm/mach-s3c24xx/mach-amlm5900.c              |    5 +-
  arch/arm/mach-s3c24xx/mach-anubis.c                |    4 +-
  arch/arm/mach-s3c24xx/mach-at2440evb.c             |    4 +-
  arch/arm/mach-s3c24xx/mach-bast.c                  |    4 +-
  arch/arm/mach-s3c24xx/mach-gta02.c                 |    4 +-
  arch/arm/mach-s3c24xx/mach-h1940.c                 |    5 +-
  arch/arm/mach-s3c24xx/mach-jive.c                  |    6 +-
  arch/arm/mach-s3c24xx/mach-mini2440.c              |    4 +-
  arch/arm/mach-s3c24xx/mach-n30.c                   |    7 +-
  arch/arm/mach-s3c24xx/mach-nexcoder.c              |    6 +-
  arch/arm/mach-s3c24xx/mach-osiris.c                |    4 +-
  arch/arm/mach-s3c24xx/mach-otom.c                  |    5 +-
  arch/arm/mach-s3c24xx/mach-qt2410.c                |    6 +-
  arch/arm/mach-s3c24xx/mach-rx1950.c                |    4 +-
  arch/arm/mach-s3c24xx/mach-rx3715.c                |    4 +-
  arch/arm/mach-s3c24xx/mach-smdk2410.c              |    7 +-
  arch/arm/mach-s3c24xx/mach-smdk2413.c              |   13 +-
  arch/arm/mach-s3c24xx/mach-smdk2416.c              |    8 +-
  arch/arm/mach-s3c24xx/mach-smdk2440.c              |    9 +-
  arch/arm/mach-s3c24xx/mach-smdk2443.c              |    9 +-
  arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    4 +-
  arch/arm/mach-s3c24xx/mach-vr1000.c                |    4 +-
  arch/arm/mach-s3c24xx/mach-vstms.c                 |    7 +-
  arch/arm/mach-s3c24xx/pm-s3c2412.c                 |    1 -
  arch/arm/mach-s3c24xx/s3c2410.c                    |    1 -
  arch/arm/mach-s3c24xx/s3c2412.c                    |    1 -
  arch/arm/mach-s3c24xx/s3c2416.c                    |    1 -
  arch/arm/mach-s3c24xx/s3c2440.c                    |    1 -
  arch/arm/mach-s3c24xx/s3c2442.c                    |    1 -
  arch/arm/mach-s3c24xx/s3c2443.c                    |    1 -
  arch/arm/mach-s3c24xx/s3c244x.c                    |    2 -
  arch/arm/mach-s3c64xx/Kconfig                      |    2 +
  arch/arm/mach-s3c64xx/mach-anw6410.c               |    4 +-
  arch/arm/mach-s3c64xx/mach-crag6410.c              |    4 +-
  arch/arm/mach-s3c64xx/mach-hmt.c                   |    4 +-
  arch/arm/mach-s3c64xx/mach-mini6410.c              |    4 +-
  arch/arm/mach-s3c64xx/mach-ncp.c                   |    4 +-
  arch/arm/mach-s3c64xx/mach-real6410.c              |    4 +-
  arch/arm/mach-s3c64xx/mach-smartq.c                |    2 +
  arch/arm/mach-s3c64xx/mach-smartq5.c               |    3 +-
  arch/arm/mach-s3c64xx/mach-smartq7.c               |    3 +-
  arch/arm/mach-s3c64xx/mach-smdk6400.c              |    4 +-
  arch/arm/mach-s3c64xx/mach-smdk6410.c              |    4 +-
  arch/arm/mach-s5p64x0/Kconfig                      |    4 +-
  arch/arm/mach-s5p64x0/mach-smdk6440.c              |    6 +-
  arch/arm/mach-s5p64x0/mach-smdk6450.c              |    6 +-
  arch/arm/mach-s5pc100/Kconfig                      |    1 +
  arch/arm/mach-s5pc100/mach-smdkc100.c              |    4 +-
  arch/arm/mach-s5pv210/Kconfig                      |    2 +-
  arch/arm/mach-s5pv210/mach-aquila.c                |    6 +-
  arch/arm/mach-s5pv210/mach-goni.c                  |    6 +-
  arch/arm/mach-s5pv210/mach-smdkc110.c              |    6 +-
  arch/arm/mach-s5pv210/mach-smdkv210.c              |    6 +-
  arch/arm/mach-s5pv210/mach-torbreck.c              |    6 +-
  arch/arm/plat-samsung/Kconfig                      |    6 +-
  arch/arm/plat-samsung/Makefile                     |    3 +-
  arch/arm/plat-samsung/include/plat/cpu.h           |    4 -
  arch/arm/plat-samsung/include/plat/irq.h           |  116 --
  arch/arm/plat-samsung/include/plat/s3c2410.h       |   31 -
  arch/arm/plat-samsung/include/plat/s3c2412.h       |   32 -
  arch/arm/plat-samsung/include/plat/s3c2416.h       |   37 -
  arch/arm/plat-samsung/include/plat/s3c2443.h       |   36 -
  arch/arm/plat-samsung/include/plat/s3c244x.h       |   42 -
  arch/arm/plat-samsung/include/plat/s5p-time.h      |   40 -
  arch/arm/plat-samsung/include/plat/samsung-time.h  |   53 +
  .../plat-samsung/{s5p-time.c => samsung-time.c}    |  138 +-
  arch/arm/plat-samsung/time.c                       |  287 ----
  drivers/clk/Makefile                               |    1 +
  drivers/clk/samsung/Makefile                       |    8 +
  drivers/clk/samsung/clk-exynos4.c                  | 1091 +++++++++++++
  drivers/clk/samsung/clk-exynos5250.c               |  523 +++++++
  drivers/clk/samsung/clk-exynos5440.c               |  139 ++
  drivers/clk/samsung/clk-pll.c                      |  419 +++++
  drivers/clk/samsung/clk-pll.h                      |   41 +
  drivers/clk/samsung/clk.c                          |  320 ++++
  drivers/clk/samsung/clk.h                          |  289 ++++
  drivers/clocksource/Kconfig                        |    5 +
  drivers/clocksource/Makefile                       |    1 +
  .../mct.c => drivers/clocksource/exynos_mct.c      |  209 ++-
  drivers/mmc/host/s3cmci.c                          |   83 +-
  144 files changed, 5417 insertions(+), 5206 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos4-clock.txt
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5250-clock.txt
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5440-clock.txt
  create mode 100644 
Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
  create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
  create mode 100644 arch/arm/boot/dts/exynos4412-odroidx.dts
  create mode 100644 arch/arm/boot/dts/exynos4412-origen.dts
  create mode 100644 arch/arm/boot/dts/exynos5250-arndale.dts
  delete mode 100644 arch/arm/mach-exynos/clock-exynos4.c
  delete mode 100644 arch/arm/mach-exynos/clock-exynos4.h
  delete mode 100644 arch/arm/mach-exynos/clock-exynos4210.c
  delete mode 100644 arch/arm/mach-exynos/clock-exynos4212.c
  delete mode 100644 arch/arm/mach-exynos/clock-exynos5.c
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-mct.h
  rename arch/arm/{plat-samsung/include/plat => 
mach-s3c24xx}/common-smdk.h (86%)
  delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-sdi.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/irq.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2410.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2412.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2416.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2443.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/s3c244x.h
  delete mode 100644 arch/arm/plat-samsung/include/plat/s5p-time.h
  create mode 100644 arch/arm/plat-samsung/include/plat/samsung-time.h
  rename arch/arm/plat-samsung/{s5p-time.c => samsung-time.c} (68%)
  delete mode 100644 arch/arm/plat-samsung/time.c
  create mode 100644 drivers/clk/samsung/Makefile
  create mode 100644 drivers/clk/samsung/clk-exynos4.c
  create mode 100644 drivers/clk/samsung/clk-exynos5250.c
  create mode 100644 drivers/clk/samsung/clk-exynos5440.c
  create mode 100644 drivers/clk/samsung/clk-pll.c
  create mode 100644 drivers/clk/samsung/clk-pll.h
  create mode 100644 drivers/clk/samsung/clk.c
  create mode 100644 drivers/clk/samsung/clk.h
  rename arch/arm/mach-exynos/mct.c => drivers/clocksource/exynos_mct.c 
(65%)

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
