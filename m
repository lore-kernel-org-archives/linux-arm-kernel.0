From: william.wu@rock-chips.com (William Wu)
Date: Fri, 12 Jan 2018 18:08:21 +0800
Subject: [PATCH 0/3] Reset USB3 controller before initializing Type-C PHY on
 rk3399
Message-ID: <1515751704-13213-1-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds USB3 OTG controller reset for rk3399 Type-C PHY, and use the
reset to hold the whole USB3 OTG controller in reset state to keep the PIPE
power state in P2 before initializing Type-C PHY, it's useful to avoid waiting
for PHY PMA and PIPE ready timeout.

William Wu (3):
  dt-bindings: phy: phy-rockchip-typec: add usb3 otg reset
  arm64: dts: rockchip: add USB3 OTG reset for Type-C PHY on rk3399
  phy: rockchip-typec: reset USB3 controller before initializing PHY

 .../devicetree/bindings/phy/phy-rockchip-typec.txt | 12 +++++++-----
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 10 ++++++----
 drivers/phy/rockchip/phy-rockchip-typec.c          | 22 ++++++++++++++++++++--
 3 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.0.0
