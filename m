From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 9 Dec 2013 07:57:38 -0600
Subject: [PATCHv5 0/4]socfpga: Enable SD/MMC support
Message-ID: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

This is v5 of the patch series to enable SD/MMC on the SOCFPGA platform.

V5 differences from V4:

* This patch series is now dependent on patch series:
  [mmc: dw_mmc: Make the use of the hold reg generic]

* Instead of re-using the platform specific "rockchip,rk2928-dw-mshc" binding,
  just use the generic "snps,dw-mshc" binding.

* No longer need to CC DTS Bindings maintainers as there aren't any new bindings.

Thanks,

Dinh Nguyen (4):
  arm: dts: Add support for SD/MMC on SOCFPGA
  clk: socfpga: Add a hook for SD/MMC driver to control CIU clock
    settings
  mmc: dw_mmc-socfpga: Remove the SOCFPGA specific platform for dw_mmc
  ARM: socfpga_defconfig: enable SD/MMC support

 arch/arm/boot/dts/socfpga.dtsi          |   11 +++
 arch/arm/boot/dts/socfpga_arria5.dtsi   |   12 +++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi |   12 +++
 arch/arm/boot/dts/socfpga_vt.dts        |   12 +++
 arch/arm/configs/socfpga_defconfig      |    2 +
 drivers/clk/socfpga/clk.c               |   25 ++++++
 drivers/mmc/host/Kconfig                |    8 --
 drivers/mmc/host/dw_mmc-socfpga.c       |  138 -------------------------------
 8 files changed, 74 insertions(+), 146 deletions(-)
 delete mode 100644 drivers/mmc/host/dw_mmc-socfpga.c

-- 
1.7.9.5
