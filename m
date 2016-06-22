From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed, 22 Jun 2016 13:42:13 +0200
Subject: [PATCH 0/5] mmc: bcm2835-sdhost: Add new driver for the internal SD
 controller.
Message-ID: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

Here is the bcm2835-sdhost driver.  Patches 1+2 are unmodified from
Eric, patches 3+4 are incremental fixes.  Left them separate for now,
to make it easier to review, should probably squashed in for the final
version.  Patch 5 adds it to the device tree, in disabled state.

Actually enabling the thing depends on a bunch of changes in the gpio
handling of the device tree.  Leaving that for another day ...

cheers,
  Gerd

Eric Anholt (2):
  dt-bindings: Add binding for brcm,bcm2835-sdhost.
  mmc: bcm2835-sdhost: Add new driver for the internal SD controller.

Gerd Hoffmann (3):
  mmc: bcm2835-sdhost: zap mmiowb() [fixup]
  mmc: bcm2835-sdhost: reset tweaks. [fixup]
  mmc: bcm2835-sdhost: add to devicetree

 .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |    3 +
 .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   24 +
 arch/arm/boot/dts/bcm283x.dtsi                     |    8 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/bcm2835-sdhost.c                  | 1652 ++++++++++++++++++++
 6 files changed, 1697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 drivers/mmc/host/bcm2835-sdhost.c

-- 
1.8.3.1
