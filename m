From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon,  3 Sep 2012 15:54:48 +0200
Subject: [PATCH 0/3] gpio-twl4030: add new device tree properties
Message-ID: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of platform data are missing when using twl4030/gpio from a
device tree. This patchset adds the missing properties, updates
existing device trees and updates the documentation of bindings.
It mainly enables LEDA and LEDB outputs, as well as pullups /
pulldowns on GPIOs.

The 1st patch changes the device driver.
The 2nd patch updates the device trees for BeagleBoard and omap3-evm.
The 3rd patch updates the documentation of bindings.

Tested:
- Boot tested on Gumstix Overo for "ti,use-leds". Corresponding
  patch is not provided, as the device tree is not yet merged.
  The support can be found in the git tree [1], branch
  omap3-devel-dt-overo.
- Device trees for BeagleBoard and omap3-evm were compiled, but not
  tested on hardware.

Would someone be willing to test on BeagleBoard / omap3-evm?

Regards,
Florian

[1] https://github.com/vaussard/linux.git (not safe for merge)


Florian Vaussard (3):
  gpio-twl4030: get platform data from device tree
  gpio-twl4030: new dt properties for BeagleBoard and omap3-EVM
  gpio-twl4030: updates the bindings for new dt properties

 .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
 arch/arm/boot/dts/omap3-beagle.dts                 |   20 +++++
 arch/arm/boot/dts/omap3-evm.dts                    |   13 +++
 drivers/gpio/gpio-twl4030.c                        |   86 +++++++++++++------
 4 files changed, 98 insertions(+), 27 deletions(-)

-- 
1.7.5.4
