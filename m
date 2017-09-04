From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  4 Sep 2017 18:30:13 +0200
Subject: [PATCH 0/1] net: mdio-mux: add mdio_mux parameter to mdio_mux_init()
Message-ID: <20170904163014.955-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

For dwmac-sun8i, we need to set a MDIO mux which is not itself a device
(it is part of a device but have its own DT node)

This patch permit to use a MDIO mux for such case.
See agreement at https://lkml.org/lkml/2017/8/29/407

Since all mdio_mux_init() users are within drivers/net/phy/ and the changes are
trivial, I have done all in one patch, instead of having a complex series of
patch converting one by one callers.

This patch is a dependency for restoring dwmac-sun8i so it is why I target "net:"
But I send it alone, for be sure that this conversion in one patch is acceptable.

Regards

Corentin Labbe (1):
  net: mdio-mux: add mdio_mux parameter to mdio_mux_init()

 drivers/net/phy/mdio-mux-bcm-iproc.c | 2 +-
 drivers/net/phy/mdio-mux-gpio.c      | 2 +-
 drivers/net/phy/mdio-mux-mmioreg.c   | 3 ++-
 drivers/net/phy/mdio-mux.c           | 7 ++++---
 include/linux/mdio-mux.h             | 9 +++++++++
 5 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.13.5
