From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 24 Jan 2013 17:07:30 +0100
Subject: [PATCH 0/3] ARM: shmobile: sh-eth pins in DT for armadillo800eva
Message-ID: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series gets rid of gpio_request()-style ethernet pin 
configuration on armadillo800eva in reference implementation.

Guennadi Liakhovetski (3):
  pinctrl: add ethernet pin groups to r8a7740
  ethernet: add a PHY reset GPIO DT binding to sh_eth
  ARM: shmobile: move pin configuration on armadillo800eva-reference to
    DT

 Documentation/devicetree/bindings/net/sh_ether.txt |    2 +
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    7 ++++
 .../board-armadillo800eva-reference.c              |   24 ---------------
 drivers/net/ethernet/renesas/sh_eth.c              |    9 +++++-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |   31 ++++++++++++++++++++
 5 files changed, 48 insertions(+), 25 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
