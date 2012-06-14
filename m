From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Jun 2012 15:59:20 +0530
Subject: [PATCH v3 0/4] dt: device tree support for TI EMIF driver for 3.6 
Message-ID: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Here is the EMIF driver DT support which was kept on hold for the driver
to get merged. The series has been already reviewed on the list.

This series adds device tree support for TI EMIF SDRAM controller
driver. For this, a binding has been added for representing AC timing
parameters and other details of LPDDR2 memories.

v3:
Rebased against the 3.5-rc2. The series is aslo available
at:
git://github.com/SantoshShilimkar/linux.git for_3.6/emif_dt

Aneesh V (4):
  dt: device tree bindings for LPDDR2 memories
  dt: emif: device tree bindings for TI's EMIF sdram controller
  arm: dts: EMIF and LPDDR2 device tree data for OMAP4 boards
  memory: emif: add device tree support to emif driver

 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   52 ++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 +++++++
 .../bindings/memory-controllers/ti/emif.txt        |   55 ++++
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   67 +++++
 arch/arm/boot/dts/omap4-panda.dts                  |   13 +
 arch/arm/boot/dts/omap4-sdp.dts                    |   13 +
 arch/arm/boot/dts/omap4.dtsi                       |   18 ++
 drivers/memory/emif.c                              |  285 +++++++++++++++++++-
 8 files changed, 604 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi

-- 
1.7.9.5
