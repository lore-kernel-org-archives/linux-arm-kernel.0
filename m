From: tthayer@altera.com (tthayer at altera.com)
Date: Wed, 25 Jun 2014 16:15:24 -0500
Subject: [PATCHv7 0/3] Addition of Altera SDRAM Controller Summary
Message-ID: <1403730927-16163-1-git-send-email-tthayer@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@altera.com>

This patch series adds Altera SDRAM EDAC support.

The one sticky issue seems to be the use of "syscon". One register
in the SDRAM controller shares bitfields with different functionality.
In this series the devicetree includes the "syscon" designation
for the SDRAM Controller [patch 1] but the bindings document does not.
This flexibility means future generations of SDRAM controller may
correct this sharing of bitfields without changes to the bindings.

Thor Thayer (3):
  devicetree: Addition of the Altera SDRAM Controller. 
    Add the Altera SDRAM controller bindings and device tree 
    changes to the Altera SoC project.
  devicetree: Addition of the Altera SDRAM EDAC. 
    Add the Altera SDRAM EDAC bindings and device tree changes 
    to the Altera SoC project.
  edac: altera: Add EDAC support for Altera SoC SDRAM Controller.    
    This patch adds support for the CycloneV and ArriaV SDRAM    
    controllers. Correction and reporting of SBEs, Panic on DBEs.

 .../bindings/arm/altera/socfpga-sdram-edac.txt     |   15 +
 .../bindings/arm/altera/socfpga-sdram.txt          |   11 +
 arch/arm/boot/dts/socfpga.dtsi                     |   11 +
 drivers/edac/Kconfig                               |    9 +
 drivers/edac/Makefile                              |    2 +
 drivers/edac/altera_edac.c                         |  448 ++++++++++++++++++++
 6 files changed, 496 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
 create mode 100644 drivers/edac/altera_edac.c

-- 
1.7.9.5
