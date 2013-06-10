From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 10 Jun 2013 18:38:06 -0500
Subject: [PATCHv7 0/6] ARM: socfpga: Add ethernet bindings, clk-gate,
 and SD/MMC
Message-ID: <1370907493-17623-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi Arnd/Olof,

Can you please apply this patch series? Arnd has already reviewed patch[6/6] and
patch [3/6] has gotten Mike Turquette's Ack-by.


Thanks,
Dinh

Dinh Nguyen (6):
  ARM: socfpga: dts: Add ethernet bindings for SOCFPGA
  ARM: socfpga: dts: Add gate-clock bindings
  ARM: socfpga: Add support to gate peripheral clocks
  ARM: socfpga: Add syscon to be part of socfpga
  ARM: socfpga: dts: Add support for SD/MMC
  mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA

 .../devicetree/bindings/clock/altr_socfpga.txt     |    7 +
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   60 +++++
 arch/arm/boot/dts/socfpga.dtsi                     |  230 +++++++++++++++++++-
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   26 +++
 arch/arm/boot/dts/socfpga_vt.dts                   |   17 ++
 arch/arm/mach-socfpga/Kconfig                      |    1 +
 drivers/clk/socfpga/clk.c                          |  194 ++++++++++++++++-
 drivers/mmc/host/Kconfig                           |    8 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |    2 -
 drivers/mmc/host/dw_mmc-socfpga.c                  |  138 ++++++++++++
 drivers/mmc/host/dw_mmc.h                          |    1 +
 12 files changed, 671 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

-- 
1.7.9.5
