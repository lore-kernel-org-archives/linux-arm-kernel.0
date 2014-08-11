From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 11 Aug 2014 10:18:11 -0500
Subject: [PATCHv10 0/2] Addition of Altera EDAC support
Message-ID: <1407770293-27190-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

The Altera SDRAM controller EDAC support is added in this
patch series. The SDRAM controller shares its registers with
the EDAC, and 2 upcoming drivers (fpga bridge and power control).
This series of patches started using the syscon driver to share
the SDRAM controller registers but met with resistance. 

In the last series of patches, this was changed to using an
MFD for the SDRAM but the suggested changes began to look more 
like the syscon interface. As a result, I'm resubmitting this
with syscon and addressing some of the objections to the use
of syscon. 

Thor Thayer (2):
  edac: altera: Add Altera SDRAM EDAC support.
  arm: dts: Add Altera SDRAM EDAC bindings & devicetree entries.

 .../bindings/arm/altera/socfpga-sdram-edac.txt     |   15 +
 MAINTAINERS                                        |    5 +
 arch/arm/boot/dts/socfpga.dtsi                     |   11 +
 drivers/edac/Kconfig                               |    9 +
 drivers/edac/Makefile                              |    2 +
 drivers/edac/altera_edac.c                         |  410 ++++++++++++++++++++
 6 files changed, 452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
 create mode 100644 drivers/edac/altera_edac.c

-- 
1.7.9.5
