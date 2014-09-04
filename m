From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Sep 2014 17:13:54 -0400
Subject: [GIT PULL] soc: Keystone SOC Navigator drivers for 3.18
Message-ID: <1409865234-9932-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm-soc folks,

Please pull below Keystone SOC drivers. They have been on the list for review
for last few merge windows. I got handful of comments on DTS bindings which
has been already addressed. This should ungate me to get network support for
Keystone which is missing in mainline.

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers-soc-ti

for you to fetch changes up to e9e7494bdcc7926237823253707691d0f3787be2:

  MAINTAINERS: Add Keystone Multicore Navigator drivers entry (2014-09-04 16:40:16 -0400)

----------------------------------------------------------------
Keystone SOC Navigator drivers for 3.18

The Keystone Multi-core Navigator contains QMSS and packet DMA
subsystems which interwork together to form the Navigator cloud
used by various subsystems like NetCP, SRIO, SideBand Crypto
engines etc.

----------------------------------------------------------------
Sandeep Nair (3):
      firmware: add Keystone QMSS PDSP accumulator firmware blob
      Documentation: dt: soc: add Keystone Navigator QMSS bindings
      soc: ti: add Keystone Navigator QMSS driver

Santosh Shilimkar (3):
      Documentation: dt: soc: add Keystone Navigator DMA bindings
      soc: ti: add Keystone Navigator DMA support
      MAINTAINERS: Add Keystone Multicore Navigator drivers entry

 .../bindings/soc/ti/keystone-navigator-dma.txt     |  111 ++
 .../bindings/soc/ti/keystone-navigator-qmss.txt    |  232 +++
 MAINTAINERS                                        |    9 +
 drivers/Kconfig                                    |    2 +
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/ti/Kconfig                             |   31 +
 drivers/soc/ti/Makefile                            |    5 +
 drivers/soc/ti/knav_dma.c                          |  815 +++++++++
 drivers/soc/ti/knav_qmss.h                         |  386 +++++
 drivers/soc/ti/knav_qmss_acc.c                     |  591 +++++++
 drivers/soc/ti/knav_qmss_queue.c                   | 1816 ++++++++++++++++++++
 firmware/Makefile                                  |    1 +
 .../keystone/qmss_pdsp_acc48_k2_le_1_0_0_8.fw.ihex |  110 ++
 include/linux/soc/ti/knav_dma.h                    |  175 ++
 include/linux/soc/ti/knav_qmss.h                   |   90 +
 16 files changed, 4376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/keystone-navigator-dma.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
 create mode 100644 drivers/soc/ti/Kconfig
 create mode 100644 drivers/soc/ti/Makefile
 create mode 100644 drivers/soc/ti/knav_dma.c
 create mode 100644 drivers/soc/ti/knav_qmss.h
 create mode 100644 drivers/soc/ti/knav_qmss_acc.c
 create mode 100644 drivers/soc/ti/knav_qmss_queue.c
 create mode 100644 firmware/keystone/qmss_pdsp_acc48_k2_le_1_0_0_8.fw.ihex
 create mode 100644 include/linux/soc/ti/knav_dma.h
 create mode 100644 include/linux/soc/ti/knav_qmss.h
