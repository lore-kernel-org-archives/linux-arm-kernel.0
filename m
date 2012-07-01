From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 1 Jul 2012 22:05:19 +0800
Subject: [GIT PULL] imx sparse-irq for 3.6
Message-ID: <20120701140517.GA21595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please pull the following imx sparse-irq support for 3.6.  Thanks.

Regards,
Shawn

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/sparse-irq

Shawn Guo (16):
      ARM: imx: eliminate macro IMX_GPIO_TO_IRQ()
      ARM: imx: eliminate macro IOMUX_TO_IRQ()
      ARM: imx: eliminate macro IRQ_GPIOx()
      gpio/mxc: move irq_domain_add_legacy call into gpio driver
      ARM: imx: move irq_domain_add_legacy call into tzic driver
      ARM: imx: move irq_domain_add_legacy call into avic driver
      dma: ipu: remove the use of ipu_platform_data
      ARM: imx: leave irq_base of wm8350_platform_data uninitialized
      ARM: imx: pass gpio than irq number into mxc_expio_init
      ARM: imx: add a legacy irqdomain for 3ds_debugboard
      ARM: imx: add a legacy irqdomain for mx31ads
      i2c: imx: remove unneeded mach/irqs.h inclusion
      ARM: imx: remove unneeded mach/irq.h inclusion
      tty: serial: imx: remove the use of MXC_INTERNAL_IRQS
      ARM: fiq: change FIQ_START to a variable
      ARM: imx: enable SPARSE_IRQ for imx platform

 arch/arm/Kconfig                                |    1 +
 arch/arm/include/asm/mach/irq.h                 |    2 +-
 arch/arm/kernel/fiq.c                           |    9 +-
 arch/arm/mach-imx/devices-imx31.h               |    4 +-
 arch/arm/mach-imx/devices-imx35.h               |    4 +-
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |    3 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c  |    6 +-
 arch/arm/mach-imx/imx27-dt.c                    |   28 ---
 arch/arm/mach-imx/imx51-dt.c                    |   27 ---
 arch/arm/mach-imx/imx53-dt.c                    |   27 ---
 arch/arm/mach-imx/mach-apf9328.c                |    7 +-
 arch/arm/mach-imx/mach-armadillo5x0.c           |   18 +-
 arch/arm/mach-imx/mach-cpuimx27.c               |   12 +-
 arch/arm/mach-imx/mach-cpuimx35.c               |    3 +-
 arch/arm/mach-imx/mach-cpuimx51sd.c             |    3 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    9 +-
 arch/arm/mach-imx/mach-imx6q.c                  |   14 --
 arch/arm/mach-imx/mach-kzm_arm11_01.c           |   20 ++-
 arch/arm/mach-imx/mach-mx1ads.c                 |    1 -
 arch/arm/mach-imx/mach-mx21ads.c                |   16 ++-
 arch/arm/mach-imx/mach-mx27_3ds.c               |    7 +-
 arch/arm/mach-imx/mach-mx27ads.c                |   12 +-
 arch/arm/mach-imx/mach-mx31_3ds.c               |   18 +--
 arch/arm/mach-imx/mach-mx31ads.c                |   63 ++++---
 arch/arm/mach-imx/mach-mx31lilly.c              |   10 +-
 arch/arm/mach-imx/mach-mx31lite.c               |   11 +-
 arch/arm/mach-imx/mach-mx31moboard.c            |   10 +-
 arch/arm/mach-imx/mach-mx35_3ds.c               |   18 +--
 arch/arm/mach-imx/mach-mx51_3ds.c               |    3 +-
 arch/arm/mach-imx/mach-mx53_ard.c               |    5 +-
 arch/arm/mach-imx/mach-mxt_td60.c               |    6 +-
 arch/arm/mach-imx/mach-pca100.c                 |    5 +-
 arch/arm/mach-imx/mach-pcm037.c                 |   24 ++--
 arch/arm/mach-imx/mach-pcm038.c                 |    4 +-
 arch/arm/mach-imx/mach-pcm043.c                 |    6 +-
 arch/arm/mach-imx/mach-qong.c                   |   10 +-
 arch/arm/mach-imx/mach-scb9328.c                |    7 +-
 arch/arm/mach-imx/mach-vpr200.c                 |   10 +-
 arch/arm/mach-imx/mm-imx1.c                     |    1 -
 arch/arm/mach-imx/mm-imx21.c                    |    1 -
 arch/arm/mach-imx/mm-imx25.c                    |    1 -
 arch/arm/mach-imx/mm-imx27.c                    |    1 -
 arch/arm/mach-imx/mm-imx3.c                     |    1 -
 arch/arm/mach-imx/mx31lilly-db.c                |   11 +-
 arch/arm/mach-imx/mx31lite-db.c                 |    5 +-
 arch/arm/mach-imx/mx51_efika.c                  |    3 +-
 arch/arm/mach-imx/pcm970-baseboard.c            |   13 +-
 arch/arm/mach-rpc/irq.c                         |    2 +-
 arch/arm/plat-mxc/3ds_debugboard.c              |   50 +++---
 arch/arm/plat-mxc/avic.c                        |   34 +++-
 arch/arm/plat-mxc/devices/platform-ipu-core.c   |    5 +-
 arch/arm/plat-mxc/include/mach/3ds_debugboard.h |    2 +-
 arch/arm/plat-mxc/include/mach/devices-common.h |    4 +-
 arch/arm/plat-mxc/include/mach/hardware.h       |    2 -
 arch/arm/plat-mxc/include/mach/iomux-mx3.h      |    3 -
 arch/arm/plat-mxc/include/mach/iomux-v1.h       |    7 -
 arch/arm/plat-mxc/include/mach/ipu.h            |    4 -
 arch/arm/plat-mxc/include/mach/irqs.h           |   44 -----
 arch/arm/plat-mxc/include/mach/mx1.h            |  111 ++++++------
 arch/arm/plat-mxc/include/mach/mx21.h           |  107 ++++++------
 arch/arm/plat-mxc/include/mach/mx25.h           |   72 ++++----
 arch/arm/plat-mxc/include/mach/mx27.h           |  127 +++++++-------
 arch/arm/plat-mxc/include/mach/mx2x.h           |   87 +++++-----
 arch/arm/plat-mxc/include/mach/mx31.h           |  118 +++++++------
 arch/arm/plat-mxc/include/mach/mx35.h           |  109 ++++++------
 arch/arm/plat-mxc/include/mach/mx3x.h           |   77 ++++----
 arch/arm/plat-mxc/include/mach/mx50.h           |  187 ++++++++++----------
 arch/arm/plat-mxc/include/mach/mx51.h           |  209 +++++++++++-----------
 arch/arm/plat-mxc/include/mach/mx53.h           |  217 ++++++++++++-----------
 arch/arm/plat-mxc/tzic.c                        |   30 +++-
 arch/arm/plat-s3c24xx/irq.c                     |    2 +-
 drivers/dma/ipu/ipu_idmac.c                     |    8 +-
 drivers/dma/ipu/ipu_irq.c                       |   14 +-
 drivers/gpio/gpio-mxc.c                         |   56 ++++---
 drivers/i2c/busses/i2c-imx.c                    |    1 -
 drivers/media/video/mx1_camera.c                |    1 +
 drivers/tty/serial/imx.c                        |    6 +-
 sound/soc/fsl/imx-pcm-fiq.c                     |    1 +
 78 files changed, 1050 insertions(+), 1127 deletions(-)
