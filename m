From: romain.perier@collabora.com (Romain Perier)
Date: Mon, 28 Aug 2017 14:16:00 +0200
Subject: [PATCH 0/4] rockchip: Add efuse support for RK3368 SoCs
Message-ID: <20170828121604.15968-1-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches exports the right clocks, add required functions
and data, and definition for enabling and supporting eFuse on RK3368
SoCs.

Romain Perier (4):
  clk: rockchip: add clock id for PCLK_EFUSE256 of RK3368 SoCs
  clk: rockchip: export clock pclk_efuse_256 for RK3368 SoCs
  nvmem: rockchip: add support for RK3368
  arm64: dts: rockchip: add efuse for RK3368 SoCs

 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  1 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           | 14 ++++
 drivers/clk/rockchip/clk-rk3368.c                  |  2 +-
 drivers/nvmem/rockchip-efuse.c                     | 80 ++++++++++++++++++++++
 include/dt-bindings/clock/rk3368-cru.h             |  1 +
 5 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.11.0
