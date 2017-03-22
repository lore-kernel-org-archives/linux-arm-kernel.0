From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 22 Mar 2017 09:54:47 +0800
Subject: [PATCH v4 0/4] RK3399 dw-mipi-dsi patches
Message-ID: <1490147691-4489-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

This series set the phy_cfg_clk to be a required clock for RK3399, and
add a grf clock control in dw-mipi-dsi driver. And then correct a
register name.


Changes in v4:
- remove "additional"
- print the err after clk_prepare_enable(dsi->grf_clk)

Changes in v3:
- add a DW_MIPI_NEEDS_PHY_CFG_CLK for RK3399
- add a DW_MIPI_NEEDS_GRF_CLK for RK3399

Changes in v2:
- check the grf_clk only for RK3399

Chris Zhong (4):
  drm/rockchip/dsi: check phy_cfg_clk only for RK3399
  dt-bindings: add the grf clock for dw-mipi-dsi
  drm/rockchip/dsi: enable the grf clk before writing grf registers
  drm/rockchip/dsi: correct the grf_switch_reg name

 .../display/rockchip/dw_mipi_dsi_rockchip.txt      |  2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 42 +++++++++++++++++-----
 2 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.6.3
