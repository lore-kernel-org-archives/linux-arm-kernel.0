From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Jun 2013 06:08:19 +0900
Subject: [GIT PULL 0/6] Samsung stuff for v3.11
Message-ID: <51B791C3.7050702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull Samsung stuff for v3.11.

If any problems, please kindly let me know.

Thanks.
- Kukjin

Dongjin Kim (2):
       ARM: dts: add max77686 node entry for ODROID-X
       ARM: dts: add vmmc regulator support for ODROID-X

Doug Anderson (1):
       ARM: EXYNOS: Select PINCTRL_EXYNOS for exynos4/5 at chip level

Girish K S (2):
       ARM: EXYNOS: force MAC ip to 32bit DMA
       ARM: dts: add dts node for the ahci sata exynos5440

Heiko Stuebner (5):
       pinctrl: Add pinctrl-s3c24xx driver
       ARM: S3C24XX: split s3c2412 spi dma channels
       ARM: S3C24XX: dma-s3c2443 - do not write into arbitary bits
       ARM: S3C24XX: remove obsolete s3c2412 specific dma settings
       ARM: dts: add devicetree support for s3c2416-smdk2416

Jingoo Han (2):
       ARM: dts: add pin state information for DP HPD support to Exynos5250
       ARM: dts: Document DP clock in samsung,exynos5-dp binding

Kukjin Kim (11):
       ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
       ARM: exynos4_defconfig: remove non-DT configuration
       Merge branch 'v3.11-next/driver-gpio' into v3.11-next/s3c24xx-driver
       Merge branch 'v3.11-next/driver-pinctrl' into 
v3.11-next/s3c24xx-driver
       Merge branch 'v3.11-next/driver-cpufreq' into 
v3.11-next/s3c24xx-driver
       Merge branch 'v3.11-next/s3c24xx-arch' into for-next
       Merge branch 'v3.11-next/s3c24xx-dt' into for-next
       Merge branch 'v3.11-next/exynos-arch' into for-next
       Merge branch 'v3.11-next/exynos-dt' into for-next
       Merge branch 'v3.11-next/remove-nondt-exynos' into for-next
       Merge branch 'v3.11-next/s3c24xx-driver' into for-next

Leela Krishna Amudala (1):
       ARM: EXYNOS: call scu_enable() only in case of cortex-A9 processor

Sachin Kamat (13):
       ARM: dts: Remove keypad entries from exynos4x12-pinctrl.dtsi
       ARM: dts: Add keypad entries to Exynos4412 based Origen
       ARM: dts: Add keypad entries to SMDK4412
       ARM: dts: Add MFC clock entries for exynos4
       ARM: dts: Update MFC documentation for clock entries
       ARM: dts: Add TMU clock entries to exynos4210.dtsi
       ARM: dts: Enable TMU on Origen4210 board
       ARM: dts: Remove combiner IRQ node from exynos4x12.dtsi
       clk: exynos4: Add additional G2D clocks
       ARM: dts: Remove duplicate and add missing G2D nodes
       ARM: dts: Add clock entries to G2D node for exynos4210
       ARM: dts: Add clock entries to G2D node for exynos4x12
       ARM: dts: Update G2D documentation for clock entries

Sylwester Nawrocki (1):
       gpio: samsung: Remove OF support for s3c24xx

Thomas Abraham (3):
       ARM: dts: add max8997 device node for exynos4210-origen board
       ARM: EXYNOS: Add a platform bus notifier to set dma masks for 
Exynos5440
       ARM: dts: add ohci and ehci controller nodes for EXYNOS5440

Vikas Sajjan (3):
       ARM: dts: Add DT node for DP controller for Arndale Board
       ARM: dts: Add clock provider information for DP controller in 
Exynos5250 SoC
       ARM: dts: Add display timing node to exynos5250-arndale.dts

Viresh Kumar (1):
       cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq

Vivek Gautam (4):
       ARM: dts: Enabling samsung-usb3phy driver for exynos5250
       ARM: dts: Add device tree bindings for dwc3-exynos
       ARM: dts: Enabling dwc3-exynos driver for exynos5250
       ARM: EXYNOS: Enable XHCI support on exynos5

Youngmin Nam (1):
       ARM: dts: Enable RTC by default on EXYNOS5440

  .../devicetree/bindings/clock/exynos4-clock.txt    |    3 +-
  .../devicetree/bindings/gpio/gpio-samsung.txt      |   43 --
  .../devicetree/bindings/gpu/samsung-g2d.txt        |    5 +
  .../devicetree/bindings/media/s5p-mfc.txt          |    5 +
  .../bindings/pinctrl/samsung-pinctrl.txt           |    8 +
  .../devicetree/bindings/usb/exynos-usb.txt         |   34 +
  .../devicetree/bindings/video/exynos_dp.txt        |    6 +
  arch/arm/Kconfig                                   |   47 --
  arch/arm/boot/dts/Makefile                         |    1 +
  arch/arm/boot/dts/exynos4.dtsi                     |    2 +
  arch/arm/boot/dts/exynos4210-origen.dts            |  147 +++++
  arch/arm/boot/dts/exynos4210.dtsi                  |    5 +
  arch/arm/boot/dts/exynos4412-odroidx.dts           |  197 ++++++
  arch/arm/boot/dts/exynos4412-origen.dts            |   66 ++
  arch/arm/boot/dts/exynos4412-smdk4412.dts          |   85 +++-
  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |   56 --
  arch/arm/boot/dts/exynos4x12.dtsi                  |   10 +-
  arch/arm/boot/dts/exynos5250-arndale.dts           |   28 +
  arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |    7 +
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    3 +
  arch/arm/boot/dts/exynos5250.dtsi                  |   34 +-
  arch/arm/boot/dts/exynos5440.dtsi                  |   25 +-
  arch/arm/boot/dts/s3c2416-pinctrl.dtsi             |  173 ++++++
  arch/arm/boot/dts/s3c2416-smdk2416.dts             |   72 +++
  arch/arm/boot/dts/s3c2416.dtsi                     |   79 +++
  arch/arm/boot/dts/s3c24xx.dtsi                     |   92 +++
  arch/arm/configs/exynos4_defconfig                 |   68 --
  arch/arm/mach-exynos/Kconfig                       |  330 +----------
  arch/arm/mach-exynos/Makefile                      |   26 -
  arch/arm/mach-exynos/common.c                      |   10 -
  arch/arm/mach-exynos/dev-ahci.c                    |  255 --------
  arch/arm/mach-exynos/dev-ohci.c                    |   52 --
  arch/arm/mach-exynos/dma.c                         |  322 ----------
  arch/arm/mach-exynos/mach-exynos5-dt.c             |   28 +
  arch/arm/mach-exynos/platsmp.c                     |    2 +-
  arch/arm/mach-exynos/pm_domains.c                  |    7 -
  arch/arm/mach-s3c24xx/Kconfig                      |   78 ++--
  arch/arm/mach-s3c24xx/Makefile                     |    7 +-
  arch/arm/mach-s3c24xx/dma-s3c2412.c                |   56 +--
  arch/arm/mach-s3c24xx/dma-s3c2443.c                |    3 +-
  arch/arm/mach-s3c24xx/dma.c                        |    3 -
  arch/arm/mach-s3c24xx/{ => include/mach}/s3c2412.h |    0
  arch/arm/mach-s3c24xx/iotiming-s3c2412.c           |    2 +-
  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |   91 +++
  arch/arm/plat-samsung/include/plat/cpu-freq-core.h |   10 +-
  arch/arm/plat-samsung/include/plat/cpu-freq.h      |    6 +-
  arch/arm/plat-samsung/include/plat/dma-s3c24xx.h   |    5 -
  drivers/clk/samsung/clk-exynos4.c                  |    9 +-
  drivers/cpufreq/Kconfig.arm                        |   58 ++
  drivers/cpufreq/Makefile                           |    5 +
  .../cpufreq/s3c2410-cpufreq.c                      |    0
  .../cpufreq/s3c2412-cpufreq.c                      |    3 +-
  .../cpufreq/s3c2440-cpufreq.c                      |    0
  .../cpufreq/s3c24xx-cpufreq-debugfs.c              |    0
  .../cpufreq.c => drivers/cpufreq/s3c24xx-cpufreq.c |    0
  drivers/gpio/gpio-samsung.c                        |   67 +--
  drivers/pinctrl/Kconfig                            |   10 +-
  drivers/pinctrl/Makefile                           |    1 +
  drivers/pinctrl/pinctrl-s3c24xx.c                  |  652 
++++++++++++++++++++
  drivers/pinctrl/pinctrl-samsung.c                  |   10 +
  drivers/pinctrl/pinctrl-samsung.h                  |    4 +
  61 files changed, 2019 insertions(+), 1394 deletions(-)
