From: aneesh@ti.com (Aneesh V)
Date: Thu,  8 Mar 2012 22:03:53 +0530
Subject: [PATCH 0/4] dt: device tree support for TI EMIF driver
Message-ID: <1331224437-4808-1-git-send-email-aneesh@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds device tree support for TI EMIF SDRAM controller
driver. For this, a binding has been added for representing AC timing
parameters and other details of LPDDR2 memories.

This series depends my series for adding EMIF driver [1]

[1] http://marc.info/?l=linux-omap&m=133122243430942&w=2

Aneesh V (4):
  dt: device tree bindings for LPDDR2 memories
  dt: emif: device tree bindings for TI's EMIF sdram controller
  arm: dts: EMIF and LPDDR2 device tree data for OMAP4 boards
  misc: emif: add device tree support to emif driver

 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   52 ++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 +++++++
 .../bindings/memory-controllers/ti/emif.txt        |   55 ++++
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   67 +++++
 arch/arm/boot/dts/omap4-panda.dts                  |   13 +
 arch/arm/boot/dts/omap4-sdp.dts                    |   13 +
 arch/arm/boot/dts/omap4.dtsi                       |   18 ++
 drivers/misc/emif.c                                |  289 +++++++++++++++++++-
 8 files changed, 608 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi
