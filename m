From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:49:54 -0500
Subject: [PATCH 0/6] Initial multi-platform support
Message-ID: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series enables initial multi-platform support for highbank, mvebu,
socfpga, picoxcell, and vexpress.

There's a couple of issues which I'm aware of:

- DEBUG_LL does not work (even for 1 platform).
- make dtbs does not work. It needs to be changes such that the build
  will iterate over mach-dirs instead of using MACHINE

This series is dependent on gpio.h clean-up and is available here:

git://sources.calxeda.com/kernel/linux.git multi-plat

Rob

Arnd Bergmann (1):
  ARM: vexpress: remove dependency on mach/* headers

Rob Herring (5):
  ARM: move ARCH config definitions into mach dirs
  ARM: introduce Kconfig.mach
  ARM: picoxcell: header fixes for multi-platform
  ARM: initial multiplatform support
  ARM: update defconfigs

 arch/arm/Kconfig                                   |  923 +-------------------
 arch/arm/Kconfig.mach                              |  585 +++++++++++++
 arch/arm/Makefile                                  |  155 ++--
 arch/arm/boot/compressed/misc.c                    |    6 +
 arch/arm/configs/acs5k_defconfig                   |    2 +-
 arch/arm/configs/acs5k_tiny_defconfig              |    2 +-
 arch/arm/configs/afeb9260_defconfig                |    2 +-
 arch/arm/configs/ag5evm_defconfig                  |    2 +-
 arch/arm/configs/am200epdkit_defconfig             |    2 +-
 arch/arm/configs/ap4evb_defconfig                  |    2 +-
 arch/arm/configs/armadillo800eva_defconfig         |    2 +-
 arch/arm/configs/assabet_defconfig                 |    2 +-
 arch/arm/configs/at91_dt_defconfig                 |    2 +-
 arch/arm/configs/at91rm9200_defconfig              |    2 +-
 arch/arm/configs/at91sam9260_defconfig             |    2 +-
 arch/arm/configs/at91sam9261_defconfig             |    2 +-
 arch/arm/configs/at91sam9263_defconfig             |    2 +-
 arch/arm/configs/at91sam9g20_defconfig             |    2 +-
 arch/arm/configs/at91sam9g45_defconfig             |    2 +-
 arch/arm/configs/at91sam9rl_defconfig              |    2 +-
 arch/arm/configs/at91x40_defconfig                 |    2 +-
 arch/arm/configs/badge4_defconfig                  |    2 +-
 arch/arm/configs/bcmring_defconfig                 |    2 +-
 arch/arm/configs/bonito_defconfig                  |    2 +-
 arch/arm/configs/cam60_defconfig                   |    2 +-
 arch/arm/configs/cerfcube_defconfig                |    2 +-
 arch/arm/configs/cm_x2xx_defconfig                 |    2 +-
 arch/arm/configs/cm_x300_defconfig                 |    2 +-
 arch/arm/configs/cns3420vb_defconfig               |    2 +-
 arch/arm/configs/colibri_pxa270_defconfig          |    2 +-
 arch/arm/configs/colibri_pxa300_defconfig          |    2 +-
 arch/arm/configs/collie_defconfig                  |    2 +-
 arch/arm/configs/corgi_defconfig                   |    2 +-
 arch/arm/configs/cpu9260_defconfig                 |    2 +-
 arch/arm/configs/cpu9g20_defconfig                 |    2 +-
 arch/arm/configs/da8xx_omapl_defconfig             |    2 +-
 arch/arm/configs/davinci_all_defconfig             |    2 +-
 arch/arm/configs/dove_defconfig                    |    2 +-
 arch/arm/configs/ebsa110_defconfig                 |    2 +-
 arch/arm/configs/edb7211_defconfig                 |    2 +-
 arch/arm/configs/em_x270_defconfig                 |    2 +-
 arch/arm/configs/ep93xx_defconfig                  |    2 +-
 arch/arm/configs/eseries_pxa_defconfig             |    2 +-
 arch/arm/configs/exynos4_defconfig                 |    2 +-
 arch/arm/configs/exynos_defconfig                  |    4 +-
 arch/arm/configs/ezx_defconfig                     |    2 +-
 arch/arm/configs/footbridge_defconfig              |    2 +-
 arch/arm/configs/fortunet_defconfig                |    2 +-
 arch/arm/configs/g3evm_defconfig                   |    2 +-
 arch/arm/configs/g4evm_defconfig                   |    2 +-
 arch/arm/configs/h3600_defconfig                   |    2 +-
 arch/arm/configs/h5000_defconfig                   |    2 +-
 arch/arm/configs/h7201_defconfig                   |    2 +-
 arch/arm/configs/h7202_defconfig                   |    2 +-
 arch/arm/configs/hackkit_defconfig                 |    2 +-
 arch/arm/configs/imote2_defconfig                  |    2 +-
 arch/arm/configs/imx_v4_v5_defconfig               |    2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |    2 +-
 arch/arm/configs/integrator_defconfig              |    2 +-
 arch/arm/configs/iop13xx_defconfig                 |    2 +-
 arch/arm/configs/iop32x_defconfig                  |    2 +-
 arch/arm/configs/iop33x_defconfig                  |    2 +-
 arch/arm/configs/ixp4xx_defconfig                  |    2 +-
 arch/arm/configs/jornada720_defconfig              |    2 +-
 arch/arm/configs/kirkwood_defconfig                |    2 +-
 arch/arm/configs/kota2_defconfig                   |    2 +-
 arch/arm/configs/ks8695_defconfig                  |    2 +-
 arch/arm/configs/kzm9d_defconfig                   |    2 +-
 arch/arm/configs/kzm9g_defconfig                   |    2 +-
 arch/arm/configs/lart_defconfig                    |    2 +-
 arch/arm/configs/lpc32xx_defconfig                 |    2 +-
 arch/arm/configs/lpd270_defconfig                  |    2 +-
 arch/arm/configs/lubbock_defconfig                 |    2 +-
 arch/arm/configs/mackerel_defconfig                |    2 +-
 arch/arm/configs/magician_defconfig                |    2 +-
 arch/arm/configs/mainstone_defconfig               |    2 +-
 arch/arm/configs/marzen_defconfig                  |    2 +-
 arch/arm/configs/mini2440_defconfig                |    2 +-
 arch/arm/configs/mmp2_defconfig                    |    2 +-
 arch/arm/configs/msm_defconfig                     |    2 +-
 arch/arm/configs/mv78xx0_defconfig                 |    2 +-
 arch/arm/configs/mvebu_defconfig                   |    2 +-
 arch/arm/configs/mxs_defconfig                     |    2 +-
 arch/arm/configs/neponset_defconfig                |    2 +-
 arch/arm/configs/netwinder_defconfig               |    2 +-
 arch/arm/configs/netx_defconfig                    |    2 +-
 arch/arm/configs/nhk8815_defconfig                 |    2 +-
 arch/arm/configs/nuc910_defconfig                  |    2 +-
 arch/arm/configs/nuc950_defconfig                  |    2 +-
 arch/arm/configs/nuc960_defconfig                  |    2 +-
 arch/arm/configs/omap1_defconfig                   |    2 +-
 arch/arm/configs/omap2plus_defconfig               |    2 +-
 arch/arm/configs/orion5x_defconfig                 |    2 +-
 arch/arm/configs/palmz72_defconfig                 |    2 +-
 arch/arm/configs/pcm027_defconfig                  |    2 +-
 arch/arm/configs/pleb_defconfig                    |    2 +-
 arch/arm/configs/pnx4008_defconfig                 |    2 +-
 arch/arm/configs/prima2_defconfig                  |    2 +-
 arch/arm/configs/pxa168_defconfig                  |    2 +-
 arch/arm/configs/pxa255-idp_defconfig              |    2 +-
 arch/arm/configs/pxa3xx_defconfig                  |    2 +-
 arch/arm/configs/pxa910_defconfig                  |    2 +-
 arch/arm/configs/qil-a9260_defconfig               |    2 +-
 arch/arm/configs/raumfeld_defconfig                |    2 +-
 arch/arm/configs/realview-smp_defconfig            |    2 +-
 arch/arm/configs/realview_defconfig                |    2 +-
 arch/arm/configs/rpc_defconfig                     |    2 +-
 arch/arm/configs/s3c2410_defconfig                 |    2 +-
 arch/arm/configs/s3c6400_defconfig                 |    2 +-
 arch/arm/configs/s5p64x0_defconfig                 |    2 +-
 arch/arm/configs/s5pc100_defconfig                 |    2 +-
 arch/arm/configs/s5pv210_defconfig                 |    2 +-
 arch/arm/configs/sam9_l9260_defconfig              |    2 +-
 arch/arm/configs/shannon_defconfig                 |    2 +-
 arch/arm/configs/shark_defconfig                   |    2 +-
 arch/arm/configs/simpad_defconfig                  |    2 +-
 arch/arm/configs/socfpga_defconfig                 |    2 +-
 arch/arm/configs/spear13xx_defconfig               |    2 +-
 arch/arm/configs/spear6xx_defconfig                |    2 +-
 arch/arm/configs/spitz_defconfig                   |    2 +-
 arch/arm/configs/stamp9g20_defconfig               |    2 +-
 arch/arm/configs/tct_hammer_defconfig              |    2 +-
 arch/arm/configs/tegra_defconfig                   |    2 +-
 arch/arm/configs/trizeps4_defconfig                |    2 +-
 arch/arm/configs/u300_defconfig                    |    2 +-
 arch/arm/configs/u8500_defconfig                   |    2 +-
 arch/arm/configs/usb-a9260_defconfig               |    2 +-
 arch/arm/configs/vexpress_defconfig                |    2 +-
 arch/arm/configs/viper_defconfig                   |    2 +-
 arch/arm/configs/xcep_defconfig                    |    2 +-
 arch/arm/configs/zeus_defconfig                    |    2 +-
 arch/arm/include/asm/timex.h                       |    4 +
 arch/arm/mach-at91/Kconfig                         |    8 +
 arch/arm/mach-bcmring/Kconfig                      |    9 +
 arch/arm/mach-clps711x/Kconfig                     |    6 +
 arch/arm/mach-cns3xxx/Kconfig                      |    9 +
 arch/arm/mach-davinci/Kconfig                      |   12 +
 arch/arm/mach-dove/Kconfig                         |    9 +
 arch/arm/mach-ebsa110/Kconfig                      |    9 +
 arch/arm/mach-ep93xx/Kconfig                       |   11 +
 arch/arm/mach-exynos/Kconfig                       |   16 +
 arch/arm/mach-footbridge/Kconfig                   |    9 +
 arch/arm/mach-gemini/Kconfig                       |    6 +
 arch/arm/mach-h720x/Kconfig                        |    6 +
 arch/arm/mach-highbank/Kconfig                     |   15 +
 arch/arm/mach-integrator/Kconfig                   |   16 +
 arch/arm/mach-iop13xx/Kconfig                      |   11 +
 arch/arm/mach-iop32x/Kconfig                       |   10 +
 arch/arm/mach-iop33x/Kconfig                       |   10 +
 arch/arm/mach-ixp4xx/Kconfig                       |   11 +
 arch/arm/mach-kirkwood/Kconfig                     |    9 +
 arch/arm/mach-ks8695/Kconfig                       |    7 +
 arch/arm/mach-lpc32xx/Kconfig                      |   12 +
 arch/arm/mach-mmp/Kconfig                          |   12 +
 arch/arm/mach-msm/Kconfig                          |    7 +
 arch/arm/mach-mv78xx0/Kconfig                      |    9 +
 arch/arm/mach-mvebu/Kconfig                        |   10 +
 arch/arm/mach-mvebu/Makefile                       |    2 +
 arch/arm/mach-mxs/Kconfig                          |   11 +
 arch/arm/mach-netx/Kconfig                         |    7 +
 arch/arm/mach-nomadik/Kconfig                      |   11 +
 arch/arm/mach-orion5x/Kconfig                      |    9 +
 arch/arm/mach-picoxcell/Kconfig                    |   14 +
 arch/arm/mach-picoxcell/common.c                   |    6 +-
 arch/arm/mach-picoxcell/include/mach/map.h         |   25 -
 .../mach-picoxcell/include/mach/picoxcell_soc.h    |   25 -
 arch/arm/mach-picoxcell/picoxcell_soc.h            |   25 +
 arch/arm/mach-pnx4008/Kconfig                      |    5 +
 arch/arm/mach-pxa/Kconfig                          |   16 +
 arch/arm/mach-realview/Kconfig                     |   15 +
 arch/arm/mach-rpc/Kconfig                          |   13 +
 arch/arm/mach-s3c24xx/Kconfig                      |   13 +
 arch/arm/mach-s3c64xx/Kconfig                      |   26 +
 arch/arm/mach-s5p64x0/Kconfig                      |   13 +
 arch/arm/mach-s5pc100/Kconfig                      |   12 +
 arch/arm/mach-s5pv210/Kconfig                      |   17 +
 arch/arm/mach-sa1100/Kconfig                       |   17 +
 arch/arm/mach-shark/Kconfig                        |   11 +
 arch/arm/mach-shmobile/Kconfig                     |   14 +
 arch/arm/mach-socfpga/Kconfig                      |   16 +
 arch/arm/mach-tegra/Kconfig                        |   13 +
 arch/arm/mach-u300/Kconfig                         |   14 +
 arch/arm/mach-ux500/Kconfig                        |   11 +
 arch/arm/mach-versatile/Kconfig                    |   16 +
 arch/arm/mach-vexpress/Kconfig                     |   16 +
 arch/arm/mach-vexpress/Makefile                    |    2 +
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    1 +
 arch/arm/mach-vexpress/include/mach/irqs.h         |    2 +
 arch/arm/mach-vt8500/Kconfig                       |    8 +
 arch/arm/mach-w90x900/Kconfig                      |    8 +
 arch/arm/mach-zynq/Kconfig                         |   10 +
 arch/arm/plat-mxc/Kconfig                          |   11 +
 arch/arm/plat-omap/Kconfig                         |    9 +
 arch/arm/plat-spear/Kconfig                        |    9 +
 arch/arm/plat-versatile/Makefile                   |    2 +
 195 files changed, 1455 insertions(+), 1178 deletions(-)
 create mode 100644 arch/arm/Kconfig.mach
 create mode 100644 arch/arm/mach-ebsa110/Kconfig
 create mode 100644 arch/arm/mach-highbank/Kconfig
 create mode 100644 arch/arm/mach-lpc32xx/Kconfig
 create mode 100644 arch/arm/mach-picoxcell/Kconfig
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/map.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
 create mode 100644 arch/arm/mach-picoxcell/picoxcell_soc.h
 create mode 100644 arch/arm/mach-pnx4008/Kconfig
 create mode 100644 arch/arm/mach-rpc/Kconfig
 create mode 100644 arch/arm/mach-shark/Kconfig
 create mode 100644 arch/arm/mach-socfpga/Kconfig
 create mode 100644 arch/arm/mach-zynq/Kconfig

-- 
1.7.9.5
