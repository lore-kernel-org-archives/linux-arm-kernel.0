From: eric@anholt.net (Eric Anholt)
Date: Wed, 20 Apr 2016 13:27:46 -0700
Subject: [GIT PULL 1/2] bcm2835 DT changes for 4.7
Message-ID: <1461184067-31925-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-dt-next-2016-04-20

for you to fetch changes up to 896ad420db8d5ec4cc4727b786d15e28eb59b366:

  dt/bindings: bcm2835: correct description for DMA-int (2016-04-19 17:31:58 -0700)

----------------------------------------------------------------
This pull request brings in VC4 devicetree support and the other minor
DT changes for 4.7.

Also included is a DRM patch necessary to prevent regressions when
simplefb and vc4 drivers are both present.  The patch was suggested by
the simplefb maintainer as the solution agreed upon at ELCE 2014, and
was acked by the DRM maintainer for merging through this tree.

----------------------------------------------------------------
Eric Anholt (2):
      drm/vc4: Kick out the simplefb framebuffer before we set up KMS.
      ARM: bcm2835: Add VC4 to the device tree.

Martin Sperl (1):
      dt/bindings: bcm2835: correct description for DMA-int

Stefan Wahren (1):
      ARM: bcm2835: add CPU node for ARM core

 .../brcm,bcm2835-armctrl-ic.txt                    |  4 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  4 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  9 +++++
 arch/arm/boot/dts/bcm2835.dtsi                     | 11 +++++
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  4 ++
 arch/arm/boot/dts/bcm283x.dtsi                     | 47 ++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c                      | 20 +++++++++
 11 files changed, 113 insertions(+), 2 deletions(-)
