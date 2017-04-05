From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed,  5 Apr 2017 16:06:09 +0200
Subject: [PATCH 0/3] rockchip dwc2: Turn off vbus on shutdown
Message-ID: <20170405140613.4444-1-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A board I'm working on seems to get its usb->sata bridge in a rather
confused state during reboot, which unfortunately can't be recovered on
the next boot (only hard reset helps).

This seems to be avoidable by turning off vbus, which turns the internal
usb hub off on shutdown.

First patch add the ability to describe vbus regulators for the rockchip
usb phy, second one starts using that on the rock2 square board and
while the final one adds the actual workaround of turning off the phy on
shutdown.


Sjoerd Simons (3):
  phy: rockchip-usb: Add vbus regulator support.
  ARM: dts: rockchip: rock2: Setup usb vbus-supply
  usb: dwc2: Power off the phy on shutdown

 .../devicetree/bindings/phy/rockchip-usb-phy.txt      |  1 +
 arch/arm/boot/dts/rk3288-rock2-square.dts             |  8 ++++----
 drivers/phy/phy-rockchip-usb.c                        | 19 +++++++++++++++++++
 drivers/usb/dwc2/platform.c                           |  3 +++
 4 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.11.0
