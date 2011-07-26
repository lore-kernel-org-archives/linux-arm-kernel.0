From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 27 Jul 2011 01:30:49 +0800
Subject: [GIT PULL] i.mx driver device tree patches for 3.1
Message-ID: <20110726173048.GA19741@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Here are a bunch of i.mx driver device tree support patches, which have
gone through the review and got acks from Grant and subsystem
maintainers (except serial).  I had ping Alan Cox several times for his
ack, but he never responded, so I Cc-ed Greg here to see if I can get
his ack on those two serial/imx patches.

The reason these patches were not included in Sascha's pull-req is they
had dependency on spi/gpio/mmc trees.  Since Linus has merged these
trees, I start sending them out.

Sascha,

Since your imx-features branch has been moving forward, I chose to send
this pull-req off arm-soc/imx/devel.  Can you please ack this pull-req?

Regards,
Shawn


The following changes since commit b7efd94751336e33fc6dd91d53ad20fd472e0400:

  Merge remote-tracking branch 'imx/imx-features' into imx-drivers-dt (2011-07-27 00:04:06 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git imx-drivers-dt

Shawn Guo (14):
      serial/imx: get rid of the uses of cpu_is_mx1()
      serial/imx: add device tree probe support
      net/fec: gasket needs to be enabled for some i.mx
      dt/net: add helper function of_get_phy_mode
      net: ibm_newemac: convert it to use of_get_phy_mode
      net/fec: add device tree probe support
      mmc: sdhci-esdhc-imx: extend card_detect and write_protect support for mx5
      mmc: sdhci-esdhc-imx: do not reference platform data after probe
      mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
      mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
      mmc: sdhci-esdhc-imx: add device tree probe support
      dmaengine: imx-sdma: use platform_device_id to identify sdma version
      dmaengine: imx-sdma: sdma_get_firmware does not need to copy fw_name
      dmaengine: imx-sdma: add device tree probe support

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   17 ++
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   34 +++
 Documentation/devicetree/bindings/net/fsl-fec.txt  |   24 ++
 .../bindings/tty/serial/fsl-imx-uart.txt           |   19 ++
 arch/arm/mach-imx/clock-imx1.c                     |    6 +-
 arch/arm/mach-imx/clock-imx21.c                    |    8 +-
 arch/arm/mach-imx/clock-imx25.c                    |   20 +-
 arch/arm/mach-imx/clock-imx27.c                    |   15 +-
 arch/arm/mach-imx/clock-imx31.c                    |   13 +-
 arch/arm/mach-imx/clock-imx35.c                    |   18 +-
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    3 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
 arch/arm/mach-imx/mach-pcm043.c                    |    2 +
 arch/arm/mach-imx/mm-imx25.c                       |    4 +-
 arch/arm/mach-imx/mm-imx31.c                       |    3 +-
 arch/arm/mach-imx/mm-imx35.c                       |    3 +-
 arch/arm/mach-mx5/board-mx51_babbage.c             |   14 +-
 arch/arm/mach-mx5/board-mx53_loco.c                |    4 +
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   46 ++--
 arch/arm/mach-mx5/mm.c                             |    8 +-
 arch/arm/mach-mx5/mx51_efika.c                     |    4 +-
 arch/arm/plat-mxc/devices/platform-fec.c           |   21 +-
 arch/arm/plat-mxc/devices/platform-imx-dma.c       |    4 +-
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |    7 +-
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   29 ++-
 arch/arm/plat-mxc/include/mach/devices-common.h    |    4 +-
 arch/arm/plat-mxc/include/mach/dma.h               |    3 +-
 arch/arm/plat-mxc/include/mach/esdhc.h             |   25 ++-
 arch/arm/plat-mxc/include/mach/sdma.h              |    2 -
 drivers/dma/imx-sdma.c                             |   94 ++++++--
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  261 +++++++++++++++-----
 drivers/mmc/host/sdhci-pltfm.c                     |    3 +-
 drivers/net/fec.c                                  |  125 +++++++++-
 drivers/net/ibm_newemac/core.c                     |   33 +---
 drivers/net/ibm_newemac/emac.h                     |   19 +-
 drivers/net/ibm_newemac/phy.c                      |    7 +-
 drivers/of/of_net.c                                |   45 ++++
 drivers/tty/serial/imx.c                           |  166 +++++++++++--
 include/linux/of_net.h                             |    1 +
 include/linux/phy.h                                |    4 +-
 41 files changed, 861 insertions(+), 262 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
 create mode 100644 Documentation/devicetree/bindings/net/fsl-fec.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
