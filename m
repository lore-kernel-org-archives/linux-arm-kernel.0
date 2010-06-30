From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 17:53:01 +0200
Subject: [PATCH 00/33] Removing dead code
Message-ID: <cover.1277911345.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all!

        As part of the VAMOS[0] research project at the University of
Erlangen we are looking at multiple integrity errors in linux'
configuration system.

	I've been running a check on the arch/arm sourcetree for
config Items not defined in Kconfig and found 33 such cases. Sourcecode
blocks depending on these Items are not reachable from a vanilla
kernel -- dead code. I've seen such dead blocks made on purpose
e.g. while integrating new features into the kernel but generally
they're just useless.

	Each of the patches in this patchset removes on such dead
config Item, I'd be glad if you consider applying them. I've been
doing deeper analysis of such issues before and can do so again but
I'm not so sure they were fastly usefull. Unfortunately arm doesn't
allow some allyesconfig build covering all of that code so I couldn't
build-test all of them, sorry for that.

        Please keep me informed of this patch getting confirmed /
merged so we can keep track of it.

Regards

        Christoph Egger

[0] http://vamos1.informatik.uni-erlangen.de/

Christoph Egger (33):
  Removing dead MTD_NAND_AT91_BUSWIDTH_16
  Removing dead ARCH_DAVINCI_TNETV107X
  Removing dead OMAP_MUX_ERRORS
  Removing dead MSM7X00A_IDLE
  Removing dead OMAP_IR
  Removing dead SHARPSL_LOCOMO
  Removing dead CPU_S3C2400
  Removing dead SA1101
  Removing dead MAGICV
  Removing dead VIDEO_AT91_ISI
  Removing dead OMAP_DSP
  Removing dead OMAP_STI
  Replacing LEDS_OMAP_DEBUG with OMAP_DEBUG_LEDS
  Removing dead SDMA_IRAM
  Removing dead PROCESSOR_NS9750
  Removing dead APM
  Removing dead SX1_OLD_FLASH
  Removing dead OMAP_ARM_96MHZ
  Removing dead MACH_OMAP_H4_OTG
  Removing dead MACH_OMAP2_H4_USB1
  Removing dead OMAP2_VENC_OUT_TYPE_SVIDEO,
    OMAP2_VENC_OUT_TYPE_COMPOSITE
  Removing dead MPU_{BRIDGE,TESLA}_IOMMU
  Removing dead BACKLIGHT_CORGI
  Removing dead ARCH_GUMSTIX_ORIG
  Removing dead CORGI_SSP_DEPRECATED
  Removing dead XSCALE_CACHE_ERRATA
  Removing dead IDE_PXA_CF
  Removing dead CPU_S3C24XX
  Removing dead SND_SOC_SMDK2443_WM9710
  Removing dead S3C_DEV_ADC
  Removing dead MACH_U300_BS26
  Removing dead CPU_ICACHE_STREAMING_DISABLE
  Removing dead MACH_U300_USE_I2S_AS_MASTER

 arch/arm/mach-at91/at572d940hf_devices.c       |   73 --
 arch/arm/mach-at91/at91sam9263_devices.c       |   49 --
 arch/arm/mach-at91/board-at572d940hf_ek.c      |    4 -
 arch/arm/mach-at91/board-sam9m10g45ek.c        |    4 -
 arch/arm/mach-davinci/include/mach/cputype.h   |    6 -
 arch/arm/mach-msm/idle.S                       |   13 -
 arch/arm/mach-ns9xxx/gpio.c                    |    8 -
 arch/arm/mach-omap1/board-h2.c                 |   18 -
 arch/arm/mach-omap1/board-nokia770.c           |  132 ----
 arch/arm/mach-omap1/board-palmte.c             |   84 ---
 arch/arm/mach-omap1/board-sx1.c                |   26 -
 arch/arm/mach-omap1/devices.c                  |   72 --
 arch/arm/mach-omap1/mcbsp.c                    |    3 -
 arch/arm/mach-omap1/mux.c                      |    5 -
 arch/arm/mach-omap1/opp_data.c                 |    3 -
 arch/arm/mach-omap2/board-h4.c                 |   26 -
 arch/arm/mach-omap2/board-omap3stalker.c       |    5 -
 arch/arm/mach-omap2/devices.c                  |   57 --
 arch/arm/mach-omap2/omap-iommu.c               |   22 -
 arch/arm/mach-pxa/corgi_pm.c                   |    2 -
 arch/arm/mach-pxa/include/mach/gumstix.h       |   12 +-
 arch/arm/mach-pxa/sharpsl_pm.c                 |   20 -
 arch/arm/mach-pxa/sleep.S                      |    7 -
 arch/arm/mach-pxa/spitz_pm.c                   |    2 -
 arch/arm/mach-pxa/trizeps4.c                   |    6 +-
 arch/arm/mach-s3c2410/include/mach/gpio-fns.h  |    5 -
 arch/arm/mach-s3c2410/include/mach/gpio.h      |    4 -
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h |    4 -
 arch/arm/mach-s3c2443/mach-smdk2443.c          |    7 -
 arch/arm/mach-s5pv210/cpu.c                    |    4 -
 arch/arm/mach-sa1100/include/mach/SA-1101.h    |  925 ------------------------
 arch/arm/mach-sa1100/include/mach/hardware.h   |    4 -
 arch/arm/mach-sa1100/include/mach/irqs.h       |    2 -
 arch/arm/mach-u300/clock.c                     |   91 ---
 arch/arm/mach-u300/core.c                      |    7 -
 arch/arm/mm/proc-arm925.S                      |    3 -
 arch/arm/plat-mxc/include/mach/mx51.h          |    4 -
 arch/arm/plat-omap/Kconfig                     |    2 +-
 arch/arm/plat-omap/debug-leds.c                |    2 +-
 arch/arm/plat-omap/devices.c                   |   62 --
 arch/arm/plat-omap/include/plat/dsp_common.h   |   40 -
 arch/arm/plat-s3c24xx/cpu.c                    |   15 -
 arch/arm/plat-s3c24xx/include/plat/s3c2400.h   |   31 -
 43 files changed, 4 insertions(+), 1867 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/SA-1101.h
 delete mode 100644 arch/arm/plat-omap/include/plat/dsp_common.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2400.h
