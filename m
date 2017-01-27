From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 27 Jan 2017 12:36:25 +0100
Subject: [PATCH 0/4] mmc: bcm2835: Add new driver for the internal SD
 controller.
Message-ID: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

Here comes the bcm2835 sdhost driver, with all cleanups squashed in, so
you see just the final result without all the inividual cleanup steps.

Patch #2 is the actual driver, commit message has some more info on the
driver.  Patches 1+3 add the device tree bits.

Patch #4 is the big red switch which activates the driver.

Tested on a rpi2 so far, and in PIO mode only.  Will looking at enabling
DMA next, and fixing whatever comes up in review of course.

please review & test,
  Gerd

Eric Anholt (2):
  dt-bindings: Add binding for brcm,bcm2835-sdhost.
  mmc: bcm2835: Add new driver for the internal SD controller.

Gerd Hoffmann (2):
  mmc: bcm2835: add internal SD controller to devicetree
  ARM: dts: bcm283x: switch from &sdhci to &sdhost

 .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   24 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |    6 +
 arch/arm/boot/dts/bcm283x.dtsi                     |    8 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/bcm2835.c                         | 1495 ++++++++++++++++++++
 6 files changed, 1543 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 drivers/mmc/host/bcm2835.c

-- 
1.8.3.1
