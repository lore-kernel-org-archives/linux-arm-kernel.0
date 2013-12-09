From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Mon,  9 Dec 2013 17:08:52 +0200
Subject: [PATCH 0/5] phy: remove the need for the phys to know about their
 users
Message-ID: <1386601737-8735-1-git-send-email-heikki.krogerus@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This replaces the consumer & init_data structures with a lookup table
that contains complete associations with the phys and their users,
removing the need for the phy drivers themselves to care about their
users even when not using DT.

The lookup method is copied from the way the gpio descriptor lookup is
now handled in gpiolib.c.


Heikki Krogerus (5):
  phy: unify the phy name parameters
  phy: add support for indexed lookup
  phy: improved lookup method
  arm: omap3: twl: use the new lookup method with usb phy
  phy: remove the old lookup method

 arch/arm/mach-omap2/twl-common.c    |  15 ++-
 drivers/phy/phy-core.c              | 209 ++++++++++++++++++++++++++----------
 drivers/phy/phy-exynos-dp-video.c   |   2 +-
 drivers/phy/phy-exynos-mipi-video.c |   2 +-
 drivers/phy/phy-omap-usb2.c         |   2 +-
 drivers/phy/phy-twl4030-usb.c       |   4 +-
 include/linux/phy/phy.h             |  86 ++++++++++-----
 7 files changed, 221 insertions(+), 99 deletions(-)

-- 
1.8.5.1
