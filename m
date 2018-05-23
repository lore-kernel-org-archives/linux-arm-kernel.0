From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 May 2018 21:07:11 +0200
Subject: [PATCH 0/5] add missing of_node_put
Message-ID: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

---

 drivers/gpu/drm/rockchip/rockchip_lvds.c   |    4 +++-
 drivers/pci/hotplug/pnv_php.c              |    8 ++++++--
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c |    9 +++++++--
 drivers/pinctrl/pinctrl-at91-pio4.c        |    4 +++-
 drivers/soc/ti/knav_dma.c                  |    1 +
 5 files changed, 20 insertions(+), 6 deletions(-)
