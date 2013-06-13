From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 13 Jun 2013 10:55:48 +0200
Subject: [PATCH v4 0/3] mmc: dw_mmc: Add support for Rockchip variant
Message-ID: <201306131055.49595.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver support for the mmc host is not needed for the core SoC support
and in the same way the mmc support does not need the SoC code to function.
Therefore it can be submitted (and hopefully merged) on its own.


Changes since v3:
- submit mmc driver standalone
- add dt binding documentation

Changes since v2:
- split "mmc: dw_mmc-pltfm: add Rockchip variant" into move and feature parts
  as suggested by Andy Shevchenko

Changes since v1:
none

Dependencies:
- "mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA" from Dinh Nguyen that
  moves the SDMMC_CMD_USE_HOLD_REG constant into the common header, which is
  required on these Rockchip SoCs 


Heiko Stuebner (3):
  mmc: dw_mmc-pltfm: remove static from dw_mci_pltfm_remove
  mmc: dw_mmc-pltfm: move probe and remove below dt match table
  mmc: dw_mmc-pltfm: add Rockchip variant

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   23 ++++++++++
 drivers/mmc/host/dw_mmc-pltfm.c                    |   47 ++++++++++++++------
 2 files changed, 56 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt

-- 
1.7.10.4
