From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue,  2 Aug 2016 15:19:54 +0800
Subject: [PATCH v3 0/7] fix and optimize some clock configuration for the
 RK3399 platfom
Message-ID: <1470122401-31934-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi:
  In the development work, we found that some of the previous
incorrect clock configuration on the RK3399 platform, we should
fix and optimize them.

Changes in v3:
- list more details of the testing steps
- add the regresson message "Fixes: 3bd14ae9da91 ..." to track the previous commit
- remove the patch "clk: rockchip: rk3399: fix incorrect parent for rk3399's {c, g}pll_aclk_perihp_src"
- add "Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>"

Changes in v2:
- add this patch " clk: rockchip: rk3399: fix incorrect GATE bits for {c, g}pll_aclk_perihp_src" into the patchset

Elaine Zhang (1):
  clk: rockchip: rk3399: delete the CLK_IGNORE_UNUSED for aclk_pcie

Xing Zheng (6):
  clk: rockchip: rk3399: export USBPHYx_480M_SRC clock IDs
  clk: rockchip: rk3399: export 480M_SRC clock id for usbphy0/usbphy1
  clk: rockchip: rk3399: fix incorrect GATE bits for {c,
    g}pll_aclk_perihp_src
  clk: rockchip: rk3399: fix incorrect aclk_emmc source gate bits
  clk: rockchip: rk3399: add 65MHz and 106.5MHz clocks for HDMI
  clk: rockchip: rk3399: Add support frac mode frequencies

 drivers/clk/rockchip/clk-rk3399.c      |   39 ++++++++++++++++++++++++--------
 include/dt-bindings/clock/rk3399-cru.h |    2 ++
 2 files changed, 32 insertions(+), 9 deletions(-)

-- 
1.7.9.5
