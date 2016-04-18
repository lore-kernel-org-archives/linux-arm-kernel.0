From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 18 Apr 2016 11:35:52 +0800
Subject: [PATCH 0/9] thermal: rockchip: Support rk3366/rk3399 SoCS and fixes
 the driver
Message-ID: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eduardo, Heiko
This series pacthes to support the rk3366/rk3399 SoCs thermal, and fixes the driver.

65ae684 thermal: rockchip: disable thermal->clk in err case
31e6d69 thermal: rockchip: fixes the code_to_temp for tsadc driver
6e2d6fb thermal: rockchip: update the tsadc table for rk3399
49f6ccf thermal: rockchip: handle the power sequence for tsadc controller
9f8bd52 thermal: rockchip: Support RK3366 SoCs in the thermal driver
a959e42 thermal: rockchip: add the notes for better reading
e5cbc6a thermal: of: Add support for hardware-tracked trip points
7f613e4 thermal: rockchip: add the set_trips function
94cc571 arm64: dts: rockchip: move the rk3368 thermal data into rk3368.dtsi

Verified on url =
https://github.com/Caesar-github/rockchip/commits/wip/fixes-rockchip-thermal-20160418
Based on linux-next kernel for 20160415

Verified on rk3288/rk3366/rk3399 SoCs with rockchip inside kernel(develop4.4).

The rk3399 dtsi has benn sent on https://patchwork.kernel.org/patch/8462441/.
The dts thermal will be updated in later.

---



Caesar Wang (6):
  thermal: rockchip: fixes the code_to_temp for tsadc driver
  thermal: rockchip: update the tsadc table for rk3399
  thermal: rockchip: handle the power sequence for tsadc controller
  thermal: rockchip: add the notes for better reading
  thermal: rockchip: add the set_trips function
  arm64: dts: rockchip: move the rk3368 thermal data into rk3368.dtsi

Elaine Zhang (1):
  thermal: rockchip: Support RK3366 SoCs in the thermal driver

Mikko Perttunen (1):
  thermal: of: Add support for hardware-tracked trip points

Shawn Lin (1):
  thermal: rockchip: disable thermal->clk in err case

 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi | 112 ---------
 arch/arm64/boot/dts/rockchip/rk3368.dtsi         |  66 ++++-
 drivers/thermal/of-thermal.c                     |  82 +++++-
 drivers/thermal/rockchip_thermal.c               | 302 ++++++++++++++++++-----
 include/linux/thermal.h                          |   2 +
 5 files changed, 388 insertions(+), 176 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi

-- 
1.9.1
