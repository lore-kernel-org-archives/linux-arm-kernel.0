From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri, 28 Aug 2015 13:46:45 +0800
Subject: [PATCH v1 0/3] Port and support rk3036 SoC platform
Message-ID: <1440740808-15004-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
We need to support rk3036 soc platform via upstream, there are
3 parts for the initial release of minimum system: dts, pinctrl,
and clock tree for rk3036, startup and run to init processs.

Thanks.


Changes in v1:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

Xing Zheng (3):
  ARM: dts: rockchip: add core rk3036 dts
  pinctrl: rockchip: add support for the rk3036
  clk: rockchip: add clock controller for rk3036

 arch/arm/boot/dts/Makefile             |    1 +
 arch/arm/boot/dts/rk3036-sdk.dts       |  362 +++++++++++++++++++++
 drivers/clk/rockchip/Makefile          |    1 +
 drivers/clk/rockchip/clk-pll.c         |  247 ++++++++++++++-
 drivers/clk/rockchip/clk-rk3036.c      |  539 ++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.h             |   30 ++
 drivers/pinctrl/pinctrl-rockchip.c     |   17 +
 include/dt-bindings/clock/rk3036-cru.h |  247 +++++++++++++++
 8 files changed, 1443 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk3036-sdk.dts
 create mode 100644 drivers/clk/rockchip/clk-rk3036.c
 create mode 100644 include/dt-bindings/clock/rk3036-cru.h

-- 
1.7.9.5
