From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 6 Jan 2014 13:32:30 -0600
Subject: [RESEND PATCHv8 0/4] socfpga: Enable SD/MMC support
Message-ID: <1389036754-7249-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

RESEND: Apologies, resending to all appropriate ml's.

Hi,

This is v8 of the patch series to enable SD/MMC on the SOCFPGA platform.

V8 differences from v7:

* For the sdmmc_clk's clk-phase binding property, use the actually degree
for the clock's phase shift.

Dinh Nguyen (4):
  clk: socfpga: Add a clk-phase property to the "altr,socfpga-gate-clk"
  dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
  mmc: dw_mmc-socfpga: Remove the SOCFPGA specific platform for dw_mmc
  ARM: socfpga_defconfig: enable SD/MMC support

 .../devicetree/bindings/clock/altr_socfpga.txt     |    5 +
 arch/arm/boot/dts/socfpga.dtsi                     |   14 +-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   11 ++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   11 ++
 arch/arm/boot/dts/socfpga_vt.dts                   |   11 ++
 arch/arm/configs/socfpga_defconfig                 |    2 +
 drivers/clk/socfpga/clk-gate.c                     |   69 ++++++++++
 drivers/mmc/host/Kconfig                           |    8 --
 drivers/mmc/host/dw_mmc-socfpga.c                  |  138 --------------------
 9 files changed, 122 insertions(+), 147 deletions(-)
 delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

-- 
1.7.9.5
