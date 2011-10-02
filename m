From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 02 Oct 2011 18:25:36 +0900
Subject: [GIT PULL] Samsung devel-2 for v3.2
Message-ID: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

This is Samsung devel for v3.2. which includes consolidation work for dma-pl330 and gpio-samsung.

Please pull from:
  git://github.com/kgene/linux-samsung.git next-samsung-devel-2

And the next-samsung-devel-2 is based on v3.1-rc8 plus next-samsung-cleanup and next-samsung-board which have been sent to arm-soc
because it has many dependencies with them so if they are missed, many conflicts will be happened. As a note, I have merged Vinod's
samsung_dma tree for dma-pl330 samsung stuff from:
  git://git.infradead.org/users/vkoul/slave-dma into next/topic-dma-samsung

If any problems, please let me know.

As a note, other next-samsung-board-2, next-samsung-soc and next-samsung-devel-3 will be sent to soon :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit bb40413ae24e3cc32bb8e949cd330a865c85e151:

  Merge branch 'next-samsung-board' into next-samsung-devel-2 (2011-09-28 21:50:01 +0900)

are available in the git repository at:

  git://github.com/kgene/linux-samsung.git next-samsung-devel-2

Ajay Kumar (5):
      ARM: S5P64X0: Add register base and IRQ for Framebuffer
      ARM: S5P64X0: Set s3c_device_fb name
      ARM: S5P64X0: Add GPIO setup for LCD
      ARM: S5P6440: Add LCD-LTE480 and enable Framebuffer support
      ARM: S5P6450: Add LCD-LTE480 and enable Framebuffer support

Alim Akhtar (3):
      ARM: EXYNOS4: register the second instance of pl330 DMAC
      ARM: S5PV210: register the second instance of pl330 DMAC
      ARM: S5PC100: register the second instance of pl330 DMAC

Boojin Kim (17):
      ARM: S5P64X0: Add the devname for DMA clock
      DMA: PL330: Add support runtime PM for PL330 DMAC
      DMA: PL330: Update PL330 DMA API driver
      DMA: PL330: Support DMA_SLAVE_CONFIG command
      DMA: PL330: Remove the start operation for handling DMA_TERMINATE_ALL command
      DMA: PL330: Add DMA_CYCLIC capability
      ARM: SAMSUNG: Update to use PL330-DMA driver
      ARM: SAMSUNG: Add common DMA operations
      ARM: EXYNOS4: Use generic DMA PL330 driver
      ARM: S5PV210: Use generic DMA PL330 driver
      ARM: S5PC100: Use generic DMA PL330 driver
      ARM: S5P64X0: Use generic DMA PL330 driver
      ARM: SAMSUNG: Remove S3C-PL330-DMA driver
      spi/s3c64xx: Add support DMA engine API
      spi/s3c64xx: Merge dma control code
      ASoC: Samsung: Update DMA interface
      ARM: SAMSUNG: Remove Samsung specific enum type for dma direction

Chanwoo Choi (1):
      ARM: EXYNOS4: Update config file of NURI to enable RTC

Giridhar Maruthy (1):
      ARM: EXYNOS4: Add PWM backlight support on ORIGEN

Guennadi Liakhovetski (1):
      dmatest: make dmatest threads freezable

Hatim Ali (1):
      ARM: EXYNOS4: Add TVOUT support for SMDKV310

Heiko Stuebner (4):
      ARM: S3C2443: Move i2s clock definitions to common code
      ARM: S3C2443: Define constant for HSSPI pclk
      ARM: S3C2416: Add HSSPI clock sourced from EPLL
      ARM: S3C2443: Add hsspi-clock from pclk and rename S3C2443 hsspi sclk

JeongHyeon Kim (1):
      ARM: EXYNOS4: Add support for ORIGEN board

Jingoo Han (1):
      ARM: EXYNOS4: Add usb ehci device to the SMDKV310

Jongpill Lee (3):
      ARM: EXYNOS4: Modify PMU register setting function
      ARM: EXYNOS4: Add PMU register definition for EXYNOS4212
      ARM: EXYNOS4: Support suspend/resume for EXYNOS4212

Kukjin Kim (18):
      Merge branch 'samsung_dma' of git://git.infradead.org/users/vkoul/slave-dma into next/topic-dma-samsung
      Merge branch 'next/topic-dma-pl330-devname-fix' into next/topic-dma-samsung
      gpio/s3c24xx: move gpio driver into drivers/gpio/
      gpio/s3c64xx: move gpio driver into drivers/gpio/
      gpio/s5p64x0: move gpio driver into drivers/gpio/
      gpio/samsung: gpio-samsung.c to support Samsung GPIOs
      ARM: SAMSUNG: Update the name of regarding Samsung GPIO
      ARM: SAMSUNG: Remove useless Samsung GPIO related CONFIGs
      Merge branch 'next/topic-plat-samsung-1' into next/topic-gpio-samsung
      Merge branch 'next/topic-s3c64xx-devel' into next-samsung-devel
      Merge branch 'next/topic-exynos4-devel' into next-samsung-devel
      Merge branch 'next/topic-dma-samsung' into next-samsung-devel
      Merge branch 'next/topic-gpio-samsung' into next-samsung-devel
      Merge branch 'next-samsung-devel' into next-samsung-devel-2
      ARM: SAMSUNG: Cleanup mach/clkdev.h
      ARM: SAMSUNG: Consolidate plat/pwm-clock.h
      ARM: SAMSUNG: Consolidate plat/pll.h
      Merge branch 'next-samsung-cleanup-2' into next-samsung-devel-2

Lothar Wa??mann (1):
      mxs-dma: enable CLKGATE before accessing registers

Marek Szyprowski (5):
      ARM: EXYNOS4: enable frame buffer on Universal C210 board
      ARM: EXYNOS4: enable frame buffer on Nuri board
      gpio/samsung: fix broken configuration for EXYNOS4 GPIO banks
      gpio/samsung: fix GPIO interrupt registration for EXYNOS4 SoCs
      gpio/samsung: correct pin configuration for S5PC100/S5PC110/EXYNOS4

Mark Brown (7):
      ARM: S3C64XX: Hook up GPIO initiated DVS on Cragganmore
      ARM: S3C64XX: Use module identification for Cragganmore system builds
      ARM: S3C64XX: Hook up some additional supplies on Cragganmore
      ARM: S3C64XX: Add devices for Kilchoman audio module on Cragganmore
      ARM: S3C64XX: Register Lowland audio device on Cragganmore
      ARM: S3C64xx: Add LDOVDD supply for CODEC on Cragganmore
      ASoC: Flush Samsung DMA on free

Nicolas Ferre (4):
      dmaengine: at_hdmac: replace spin_lock* with irqsave variants
      dmaengine: at_hdmac: improve power management routines
      dmaengine: at_hdmac: add wrappers for testing channel state
      dmaengine: at_hdmac: fix way to specify cyclic capability

Per Forlin (4):
      dmaengine/ste_dma40: add missing kernel doc for pending_queue
      dmaengine/ste_dma40: remove duplicate call to d40_pool_lli_free().
      dmaengine/ste_dma40: fix Oops due to double free of client descriptor
      dmaengine/ste_dma40: fix memory leak due to prepared descriptors

Russell King - ARM Linux (1):
      dmaengine: amba-pl08x: make filter check that the channel is owned by pl08x

Sachin Kamat (7):
      ARM: EXYNOS4: Add USB EHCI device to ORIGEN board
      ARM: EXYNOS4: Add FIMC device on ORIGEN board
      ARM: EXYNOS4: Add keypad support for ORIGEN
      ARM: EXYNOS4: Add HDMI support for ORIGEN
      ARM: EXYNOS4: Enable MFC on Samsung SMDKV310
      ARM: EXYNOS4: Add header file protection macros
      ARM: EXYNOS4: Add FIMC device on SMDKV310 board

Sascha Hauer (3):
      dmaengine i.MX SDMA: lock channel 0
      dmaengine i.MX SDMA: set firmware scripts addresses to negative value initially
      dmaengine i.MX SDMA: use request_firmware_nowait

Sylwester Nawrocki (2):
      ARM: S5PV210: Add support for NOON010PC30 sensor on GONI board
      ARM: S5PV210: UNIVERSAL_C210: Add support for M-5MOLS image sensor

Tomasz Figa (4):
      ARM: S3C64XX: Use S3C64XX_SDMA_SEL register name instead of numeric address
      ARM: S3C64XX: Save/restore S3C64XX_SDMA_SEL on suspend/resume
      ARM: S3C64XX: Save/restore S3C64XX_MODEM_MIFPCON on suspend/resume
      ARM: S3C64XX: Add support for synchronous clock operation

Tomasz Stanislawski (4):
      ARM: SAMSUNG: add i2c hdmiphy controller definitions
      ARM: S5P: add support for tv device
      ARM: EXYNOS4: enable TV support on Universal_C210 board
      ARM: S5PV210: enable TV support on GONI board

Tushar Behera (2):
      ARM: EXYNOS4: Fix sdhci card detection for ORIGEN
      ARM: EXYNOS4: Add support for secondary MMC port on ORIGEN

Vinod Koul (3):
      dmaengine: add helper function for slave_single
      dmaengine: remove struct scatterlist for header
      Merge branch 'next' into v3.1-rc4

Viresh Kumar (19):
      dmaengine/dmatest: Terminate transfers on all channels in case of error or exit
      ARM: asm/pl080.h: Protect against multiple inclusion of header file
      dmaengine/amba-pl08x: Resolve formatting issues
      dmaengine/amba-pl08x: Rearrange inclusion of header files in ascending order
      dmaengine/amba-pl08x: pass (*ptr) to sizeof() instead of (struct xyz)
      dmaengine/amba-pl08x: Complete doc comment for struct pl08x_txd
      dmaengine/amba-pl08x: Remove redundant comment and rewrite original
      dmaengine/amba-pl08x: Changing few prints to dev_dbg from dev_info
      dmaengine/amba-pl08x: support runtime PM
      dmaengine/amba-pl08x: Simplify pl08x_ensure_on()
      dmaengine/amba-pl08x: No need to check "ch->signal < 0"
      dmaengine/amba-pl08x: Schedule tasklet in case of error interrupt
      dmaengine/amba-pl08x: Get rid of pl08x_pre_boundary()
      dmaengine/amba-pl08x: max_bytes_per_lli is TRANSFER_SIZE * src_width (not MIN(width))
      dmaengine/amba-pl08x: Add prep_single_byte_llis() routine
      dmaengine/amba-pl08x: Align lli_len to max(src.width, dst.width)
      dmaengine/amba-pl08x: Choose peripheral bus as master bus
      dmaengine/amba-pl08x: Pass flow controller information with slave channel data
      dmaengine/amba-pl08x: Call pl08x_free_txd() instead of calling kfree() directly

Vladimir Zapolskiy (3):
      ARM: EXYNOS4: use dma-pl330 device name for clock
      ARM: S5PC100: use dma-pl330 device name for clock
      ARM: S5PV210: use dma-pl330 device name for clock

 arch/arm/Kconfig                                   |    3 -
 arch/arm/include/asm/hardware/pl080.h              |    4 +
 arch/arm/mach-exynos4/Kconfig                      |   34 +-
 arch/arm/mach-exynos4/clock.c                      |  220 ++-
 arch/arm/mach-exynos4/cpu.c                        |    2 +
 arch/arm/mach-exynos4/dma.c                        |  300 ++-
 arch/arm/mach-exynos4/include/mach/clkdev.h        |    7 -
 arch/arm/mach-exynos4/include/mach/dma.h           |    4 +-
 arch/arm/mach-exynos4/include/mach/i2c-hdmiphy.h   |   16 +
 arch/arm/mach-exynos4/include/mach/irqs.h          |    4 +
 arch/arm/mach-exynos4/include/mach/map.h           |   12 +
 arch/arm/mach-exynos4/include/mach/pm-core.h       |    8 +-
 arch/arm/mach-exynos4/include/mach/pmu.h           |    7 +
 arch/arm/mach-exynos4/include/mach/regs-pmu.h      |   74 +-
 arch/arm/mach-exynos4/mach-nuri.c                  |   34 +
 arch/arm/mach-exynos4/mach-origen.c                |  115 +-
 arch/arm/mach-exynos4/mach-smdkv310.c              |   49 +
 arch/arm/mach-exynos4/mach-universal_c210.c        |  312 +++-
 arch/arm/mach-exynos4/pm.c                         |    7 +
 arch/arm/mach-exynos4/pmu.c                        |  353 ++--
 arch/arm/mach-s3c2410/Kconfig                      |    1 -
 arch/arm/mach-s3c2410/include/mach/dma.h           |   20 +-
 arch/arm/mach-s3c2410/include/mach/gpio-fns.h      |   99 +-
 arch/arm/mach-s3c2410/include/mach/gpio-track.h    |    6 +-
 arch/arm/mach-s3c2410/include/mach/pm-core.h       |    2 +-
 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    1 +
 arch/arm/mach-s3c2410/mach-h1940.c                 |    6 +-
 arch/arm/mach-s3c2410/s3c2410.c                    |    4 +-
 arch/arm/mach-s3c2412/dma.c                        |    4 +-
 arch/arm/mach-s3c2416/Kconfig                      |    1 -
 arch/arm/mach-s3c2416/clock.c                      |   29 +-
 arch/arm/mach-s3c2416/s3c2416.c                    |    4 +-
 arch/arm/mach-s3c2440/Kconfig                      |    2 -
 arch/arm/mach-s3c2440/s3c2440.c                    |    4 +-
 arch/arm/mach-s3c2440/s3c2442.c                    |    4 +-
 arch/arm/mach-s3c2443/Kconfig                      |    1 -
 arch/arm/mach-s3c2443/clock.c                      |   55 +-
 arch/arm/mach-s3c2443/s3c2443.c                    |    4 +-
 arch/arm/mach-s3c64xx/Kconfig                      |    1 +
 arch/arm/mach-s3c64xx/Makefile                     |    3 +-
 arch/arm/mach-s3c64xx/clock.c                      |   13 +-
 arch/arm/mach-s3c64xx/dma.c                        |   12 +-
 arch/arm/mach-s3c64xx/gpiolib.c                    |  290 ---
 arch/arm/mach-s3c64xx/include/mach/clkdev.h        |    7 -
 arch/arm/mach-s3c64xx/include/mach/crag6410.h      |   23 +
 arch/arm/mach-s3c64xx/include/mach/dma.h           |    8 +-
 arch/arm/mach-s3c64xx/include/mach/pll.h           |   45 -
 arch/arm/mach-s3c64xx/include/mach/pm-core.h       |    2 +-
 arch/arm/mach-s3c64xx/include/mach/pwm-clock.h     |   56 -
 arch/arm/mach-s3c64xx/include/mach/regs-sys.h      |    3 +
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |  182 ++
 arch/arm/mach-s3c64xx/mach-crag6410.c              |  106 +-
 arch/arm/mach-s3c64xx/pm.c                         |    4 +
 arch/arm/mach-s5p64x0/Kconfig                      |   14 +-
 arch/arm/mach-s5p64x0/Makefile                     |    3 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |   10 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |   10 +-
 arch/arm/mach-s5p64x0/cpu.c                        |    3 +
 arch/arm/mach-s5p64x0/dma.c                        |  269 ++-
 arch/arm/mach-s5p64x0/gpiolib.c                    |  508 ----
 arch/arm/mach-s5p64x0/include/mach/clkdev.h        |    7 -
 arch/arm/mach-s5p64x0/include/mach/dma.h           |    4 +-
 arch/arm/mach-s5p64x0/include/mach/irqs.h          |    4 +
 arch/arm/mach-s5p64x0/include/mach/map.h           |    3 +
 arch/arm/mach-s5p64x0/include/mach/pwm-clock.h     |   68 -
 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h     |    4 +
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |   74 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |   75 +
 arch/arm/mach-s5p64x0/setup-fb-24bpp.c             |   29 +
 arch/arm/mach-s5pc100/Kconfig                      |    2 +-
 arch/arm/mach-s5pc100/clock.c                      |   15 +-
 arch/arm/mach-s5pc100/dma.c                        |  324 ++-
 arch/arm/mach-s5pc100/include/mach/clkdev.h        |    7 -
 arch/arm/mach-s5pc100/include/mach/dma.h           |    4 +-
 arch/arm/mach-s5pc100/include/mach/pwm-clock.h     |   56 -
 arch/arm/mach-s5pv210/Kconfig                      |    4 +-
 arch/arm/mach-s5pv210/clock.c                      |  151 +-
 arch/arm/mach-s5pv210/cpu.c                        |    4 +
 arch/arm/mach-s5pv210/dma.c                        |  317 ++-
 arch/arm/mach-s5pv210/include/mach/clkdev.h        |    7 -
 arch/arm/mach-s5pv210/include/mach/dma.h           |    4 +-
 arch/arm/mach-s5pv210/include/mach/i2c-hdmiphy.h   |   16 +
 arch/arm/mach-s5pv210/include/mach/irqs.h          |    4 +-
 arch/arm/mach-s5pv210/include/mach/map.h           |   13 +
 arch/arm/mach-s5pv210/include/mach/pm-core.h       |    2 +-
 arch/arm/mach-s5pv210/include/mach/pwm-clock.h     |   70 -
 arch/arm/mach-s5pv210/include/mach/regs-clock.h    |    3 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |   62 +
 arch/arm/plat-s3c24xx/Kconfig                      |    1 -
 arch/arm/plat-s3c24xx/Makefile                     |    2 -
 arch/arm/plat-s3c24xx/dma.c                        |   10 +-
 arch/arm/plat-s3c24xx/gpio.c                       |   96 -
 arch/arm/plat-s3c24xx/gpiolib.c                    |  229 --
 arch/arm/plat-s3c24xx/include/mach/clkdev.h        |    7 -
 arch/arm/plat-s3c24xx/include/mach/pwm-clock.h     |   55 -
 arch/arm/plat-s3c24xx/include/plat/pll.h           |   62 -
 arch/arm/plat-s3c24xx/s3c2443-clock.c              |   57 +
 arch/arm/plat-s5p/Kconfig                          |   13 +-
 arch/arm/plat-s5p/Makefile                         |    2 +
 arch/arm/plat-s5p/dev-i2c-hdmiphy.c                |   59 +
 arch/arm/plat-s5p/dev-tv.c                         |   98 +
 arch/arm/plat-s5p/include/plat/pll.h               |  203 --
 arch/arm/plat-s5p/irq-gpioint.c                    |   10 +-
 arch/arm/plat-samsung/Kconfig                      |   36 +-
 arch/arm/plat-samsung/Makefile                     |    6 +-
 arch/arm/plat-samsung/dma-ops.c                    |  131 +
 arch/arm/plat-samsung/gpio-config.c                |  431 ----
 arch/arm/plat-samsung/gpio.c                       |  167 --
 arch/arm/plat-samsung/include/plat/devs.h          |    6 +
 arch/arm/plat-samsung/include/plat/dma-ops.h       |   63 +
 .../include/plat/{s3c-dma-pl330.h => dma-pl330.h}  |   24 +-
 arch/arm/plat-samsung/include/plat/dma-s3c24xx.h   |    2 +-
 arch/arm/plat-samsung/include/plat/dma.h           |   10 +-
 arch/arm/plat-samsung/include/plat/fb.h            |    7 +
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |  172 +-
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      |   34 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h     |   97 +-
 arch/arm/plat-samsung/include/plat/gpio-fns.h      |   98 +
 arch/arm/plat-samsung/include/plat/iic.h           |    1 +
 arch/arm/plat-samsung/include/plat/pll.h           |  323 +++
 arch/arm/plat-samsung/include/plat/pll6553x.h      |   51 -
 arch/arm/plat-samsung/include/plat/pm.h            |   10 +-
 .../mach => plat-samsung/include/plat}/pwm-clock.h |   39 +-
 .../plat-samsung/include/plat/s3c-pl330-pdata.h    |   32 -
 arch/arm/plat-samsung/include/plat/tv-core.h       |   44 +
 arch/arm/plat-samsung/pm-gpio.c                    |   72 +-
 arch/arm/plat-samsung/pm.c                         |    6 +-
 arch/arm/plat-samsung/pwm-clock.c                  |   13 +-
 arch/arm/plat-samsung/s3c-dma-ops.c                |  130 +
 arch/arm/plat-samsung/s3c-pl330.c                  | 1244 ---------
 drivers/dma/Kconfig                                |    3 +-
 drivers/dma/amba-pl08x.c                           |  455 ++--
 drivers/dma/at_hdmac.c                             |  159 +-
 drivers/dma/at_hdmac_regs.h                        |   24 +
 drivers/dma/dmatest.c                              |   23 +-
 drivers/dma/imx-sdma.c                             |   47 +-
 drivers/dma/mxs-dma.c                              |   45 +-
 drivers/dma/pl330.c                                |  229 ++-
 drivers/gpio/Kconfig                               |   16 -
 drivers/gpio/Makefile                              |    7 +-
 drivers/gpio/gpio-exynos4.c                        |  385 ---
 drivers/gpio/gpio-plat-samsung.c                   |  205 --
 drivers/gpio/gpio-s5pc100.c                        |  354 ---
 drivers/gpio/gpio-s5pv210.c                        |  287 ---
 drivers/gpio/gpio-samsung.c                        | 2688 ++++++++++++++++++++
 drivers/mmc/host/s3cmci.c                          |    6 +-
 drivers/spi/spi-s3c64xx.c                          |  175 +-
 include/linux/amba/pl08x.h                         |   14 +-
 include/linux/amba/pl330.h                         |    6 +-
 include/linux/dmaengine.h                          |   13 +-
 sound/soc/samsung/ac97.c                           |   10 +-
 sound/soc/samsung/dma.c                            |  148 +-
 sound/soc/samsung/dma.h                            |    4 +-
 153 files changed, 7418 insertions(+), 6755 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-exynos4/include/mach/i2c-hdmiphy.h
 delete mode 100644 arch/arm/mach-s3c64xx/gpiolib.c
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-s3c64xx/include/mach/crag6410.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/pll.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
 create mode 100644 arch/arm/mach-s3c64xx/mach-crag6410-module.c
 delete mode 100644 arch/arm/mach-s5p64x0/gpiolib.c
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/pwm-clock.h
 create mode 100644 arch/arm/mach-s5p64x0/setup-fb-24bpp.c
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/i2c-hdmiphy.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/plat-s3c24xx/gpio.c
 delete mode 100644 arch/arm/plat-s3c24xx/gpiolib.c
 delete mode 100644 arch/arm/plat-s3c24xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/pll.h
 create mode 100644 arch/arm/plat-s5p/dev-i2c-hdmiphy.c
 create mode 100644 arch/arm/plat-s5p/dev-tv.c
 delete mode 100644 arch/arm/plat-s5p/include/plat/pll.h
 create mode 100644 arch/arm/plat-samsung/dma-ops.c
 delete mode 100644 arch/arm/plat-samsung/gpio-config.c
 delete mode 100644 arch/arm/plat-samsung/gpio.c
 create mode 100644 arch/arm/plat-samsung/include/plat/dma-ops.h
 rename arch/arm/plat-samsung/include/plat/{s3c-dma-pl330.h => dma-pl330.h} (84%)
 create mode 100644 arch/arm/plat-samsung/include/plat/gpio-fns.h
 create mode 100644 arch/arm/plat-samsung/include/plat/pll.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/pll6553x.h
 rename arch/arm/{mach-exynos4/include/mach => plat-samsung/include/plat}/pwm-clock.h (68%)
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c-pl330-pdata.h
 create mode 100644 arch/arm/plat-samsung/include/plat/tv-core.h
 create mode 100644 arch/arm/plat-samsung/s3c-dma-ops.c
 delete mode 100644 arch/arm/plat-samsung/s3c-pl330.c
 delete mode 100644 drivers/gpio/gpio-exynos4.c
 delete mode 100644 drivers/gpio/gpio-plat-samsung.c
 delete mode 100644 drivers/gpio/gpio-s5pc100.c
 delete mode 100644 drivers/gpio/gpio-s5pv210.c
 create mode 100644 drivers/gpio/gpio-samsung.c
