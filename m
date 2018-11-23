From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 17:17:24 +0100
Subject: [PATCH v2 0/6] Add hw overheat IRQ support to Marvell thermal driver
Message-ID: <20181123161730.11289-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the last batch of patches about the thermal driver that was
suspended, waiting for the ICU/SEI series to be merged. Now that
everything is ready in mainline, let's add hardware overheat interrupt
support to this driver.

Bindings and DT are updated accordingly. The interrupt will only be
triggered if the platform goes above 102?C (threshold set to 100?C,
hysteresis to > 2?C). The interrupt property is of course not
mandatory.

In the mean time, I add myself to the MAINTAINERS file to receive and
review possible fixes/new features.

Comments are welcome.

Thanks,
Miqu?l


Changes since v1:
=================
* Use a threaded IRQ handler to avoid a potential lock depency when
  notifying the core of an overheat situation.


Miquel Raynal (6):
  thermal: armada: add overheat interrupt support
  MAINTAINERS: thermal: add entry for Marvell MVEBU thermal driver
  dt-bindings: ap806: document the thermal interrupt capabilities
  dt-bindings: cp110: document the thermal interrupt capabilities
  arm64: dts: marvell: add interrupt support to ap806 thermal node
  arm64: dts: marvell: add interrupt support to cp110 thermal node

 .../arm/marvell/ap806-system-controller.txt   |   8 +
 .../arm/marvell/cp110-system-controller.txt   |   9 +
 MAINTAINERS                                   |   5 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |  18 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi |  15 +-
 drivers/thermal/armada_thermal.c              | 270 +++++++++++++++++-
 6 files changed, 318 insertions(+), 7 deletions(-)

-- 
2.19.1
