From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu, 14 Dec 2017 11:30:00 +0100
Subject: [PATCH v3 00/11] Armada thermal: improvements and A7K/A8K SoCs support
Message-ID: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series takes over Baruch's series by integrating his patches about
supporting thermal on Armada 7K and 8K SoCs within a larger series with
several improvements on the armada_thermal.c driver.

For now, Armada 380 and CP110 compatibles share the same initialization
routine but this will probably change in the near future when adding
support for overheat interrupts.

DT bindings documentation is updated to match existing code. A new
property is introduced to identify thermal zones, see the commit using
it for more details.

Armada AP806 and CP110 DT are also updated with thermal nodes.

Thank you,
Miqu?l


Baruch Siach (4):
  dt-bindings: thermal: Describe Armada AP806 and CP110
  thermal: armada: Use msleep for long delays
  thermal: armada: Add support for Armada AP806
  thermal: armada: Add support for Armada CP110

Miquel Raynal (7):
  thermal: armada: Simplify the check of the validity bit
  thermal: armada: Rationalize register accesses
  thermal: armada: Update Kconfig and module description
  thermal: armada: Change sensors trim default value
  thermal: armada: Wait sensors validity before exiting the init
    callback
  thermal: armada: Give useful names to the thermal zone
  ARM64: dts: marvell: Add thermal support for A7K/A8K

 .../devicetree/bindings/thermal/armada-thermal.txt |  29 ++-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   7 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      |   7 +
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   7 +
 drivers/thermal/Kconfig                            |   4 +-
 drivers/thermal/armada_thermal.c                   | 225 ++++++++++++++++-----
 6 files changed, 222 insertions(+), 57 deletions(-)

-- 
2.11.0
