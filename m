From: eric@anholt.net (Eric Anholt)
Date: Fri, 26 Feb 2016 15:05:38 -0800
Subject: [PATCH 0/4] bcm2835 SDHOST controller
Message-ID: <1456527942-3045-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a series to enable the SDHOST controller.  It gives us better
performance than our old sdhci-bcm2835.c.  The downstream Raspberry Pi
kernel appears to be using this controller by default at this point.

I've tried to do some testing on it (mounting filesystem,
reading/writing files, speed tests), but I'm not sure what a good
testing regimen for storage drivers would be.

Eric Anholt (4):
  dt-bindings: Add binding for brcm,bcm2835-sdhost.
  mmc: bcm2835-sdhost: Add new driver for the internal SD controller.
  ARM: bcm2835: Include SDHOST in the device tree.
  ARM: bcm2835: Enable SDHOST by default.

 .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   25 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   10 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |    8 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/bcm2835-sdhost.c                  | 1652 ++++++++++++++++++++
 6 files changed, 1704 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 drivers/mmc/host/bcm2835-sdhost.c

-- 
2.7.0
