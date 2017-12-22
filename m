From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri, 22 Dec 2017 10:32:15 +0100
Subject: [PATCH v6 00/11] Armada thermal: improvements and A7K/A8K SoCs support
Message-ID: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series takes over Baruch's series by integrating his patches about
supporting thermal on Armada 7K and 8K SoCs within a larger series with
several improvements on the armada_thermal.c driver.

For now, Armada 380 and CP110 compatibles share the same initialization
routine but this will probably change in the near future when adding
support for overheat interrupts.

DT bindings documentation is updated to match existing code.

Armada AP806 and CP110 DT are also updated with thermal nodes and have
already been accepted (thus absent in this series).

Thank you,
Miqu?l


Changes since v5:
  - Added Grogory's Tested-by tags for 64-bit platforms in patches:
        "thermal: armada: Add support for Armada AP806"
	"thermal: armada: Add support for Armada CP110"
  - Fixed a compilation issue with 32-bit toolchains introduced in patch:
        "thermal: armada: Add support for Armada AP806"


Baruch Siach (4):
  dt-bindings: thermal: Describe Armada AP806 and CP110
  thermal: armada: Use msleep for long delays
  thermal: armada: Add support for Armada AP806
  thermal: armada: Add support for Armada CP110

Miquel Raynal (7):
  thermal: armada: Simplify the check of the validity bit
  thermal: armada: Clarify control registers accesses
  thermal: armada: Use real status register name
  thermal: armada: Update Kconfig and module description
  thermal: armada: Change sensors trim default value
  thermal: armada: Wait sensors validity before exiting the init
    callback
  thermal: armada: Give meaningful names to the thermal zones

 .../devicetree/bindings/thermal/armada-thermal.txt |  37 ++-
 drivers/thermal/Kconfig                            |   4 +-
 drivers/thermal/armada_thermal.c                   | 257 +++++++++++++++------
 3 files changed, 218 insertions(+), 80 deletions(-)

-- 
2.11.0
