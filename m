From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 4 Jun 2015 09:28:44 -0500
Subject: [PATCHv2 0/4] Add Altera Arria10 EDAC Support
Message-ID: <1433428128-7292-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This series of patches adds support for the Arria10 EDAC. The
SDRAM controller and ECC registers are significantly different
from the CycloneV/ArriaV but common areas could be abstracted.

Thor Thayer (4):
  edac, altera: Generalize driver to use DT Memory size
  edac, altera: Refactor EDAC for Altera CycloneV SoC.
  edac, altera: Addition of Arria10 EDAC
  arm: socfpga: dts: Arria10 SDRAM EDAC DTS additions.

 .../bindings/arm/altera/socfpga-sdram-edac.txt     |    2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   11 +
 drivers/edac/altera_edac.c                         |  364 ++++++++++++--------
 drivers/edac/altera_edac.h                         |  201 +++++++++++
 4 files changed, 437 insertions(+), 141 deletions(-)
 create mode 100644 drivers/edac/altera_edac.h

-- 
1.7.9.5
