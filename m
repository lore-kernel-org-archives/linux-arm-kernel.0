From: tthayer@altera.com (tthayer at altera.com)
Date: Fri, 20 Jun 2014 18:16:56 -0500
Subject: [PATCHv6 0/3] Addition of Altera SDRAM EDAC
In-Reply-To: <1403306219-3903-1-git-send-email-tthayer@altera.com>
References: <1403306219-3903-1-git-send-email-tthayer@altera.com>
Message-ID: <1403306219-3903-2-git-send-email-tthayer@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@altera.com>

Addition of the Altera SDRAM controller to the EDAC driver.

Thor Thayer (3):
  Addition of the Altera SDRAM controller bindings and device     tree
    changes to the Altera SoC project.
  Addition of the Altera SDRAM EDAC bindings and device     tree
    changes to the Altera SoC project.
  edac: altera: Add EDAC support for Altera SoC SDRAM Controller.    
    This patch adds support for the CycloneV and ArriaV SDRAM    
    controllers.     Correction and reporting of SBEs, Panic on DBEs.

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
