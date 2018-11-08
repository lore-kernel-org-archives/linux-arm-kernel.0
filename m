From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 9 Nov 2018 00:26:08 +0100
Subject: [PATCH net-next v2 0/2] net: phy: replace PHY_HAS_INTERRUPT with a
 check for config_intr and ack_interrupt
Message-ID: <a02d084d-291a-dd62-c370-c1a2dec451c7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flag PHY_HAS_INTERRUPT is used only here for this small check. I think
using interrupts isn't possible if a driver defines neither
config_intr nor ack_interrupts callback. So we can replace checking
flag PHY_HAS_INTERRUPT with checking for these callbacks.
This allows to remove this flag from all driver configs.

v2:
- add helper for check in patch 1
- remove PHY_HAS_INTERRUPT from all drivers, not only Realtek
- remove flag PHY_HAS_INTERRUPT completely

Heiner Kallweit (2):
  net: phy: replace PHY_HAS_INTERRUPT with a check for config_intr and ack_interrupt
  net: phy: realtek: remove flag PHY_HAS_INTERRUPT from driver configs

 drivers/net/phy/amd.c          |  1 -
 drivers/net/phy/aquantia.c     |  6 ------
 drivers/net/phy/at803x.c       |  3 ---
 drivers/net/phy/bcm63xx.c      |  4 ++--
 drivers/net/phy/bcm87xx.c      |  2 --
 drivers/net/phy/broadcom.c     | 16 ----------------
 drivers/net/phy/cicada.c       |  2 --
 drivers/net/phy/davicom.c      |  4 ----
 drivers/net/phy/dp83640.c      |  1 -
 drivers/net/phy/dp83822.c      |  1 -
 drivers/net/phy/dp83848.c      |  1 -
 drivers/net/phy/dp83867.c      |  1 -
 drivers/net/phy/dp83tc811.c    |  1 -
 drivers/net/phy/icplus.c       |  1 -
 drivers/net/phy/intel-xway.c   | 10 ----------
 drivers/net/phy/lxt.c          |  2 --
 drivers/net/phy/marvell.c      | 15 ---------------
 drivers/net/phy/meson-gxl.c    |  2 +-
 drivers/net/phy/micrel.c       | 14 --------------
 drivers/net/phy/microchip.c    |  1 -
 drivers/net/phy/microchip_t1.c |  1 -
 drivers/net/phy/mscc.c         |  6 ------
 drivers/net/phy/national.c     |  1 -
 drivers/net/phy/phy_device.c   |  8 ++++++--
 drivers/net/phy/qsemi.c        |  1 -
 drivers/net/phy/realtek.c      |  7 -------
 drivers/net/phy/smsc.c         |  7 +------
 drivers/net/phy/ste10Xp.c      |  2 --
 drivers/net/phy/vitesse.c      |  9 ---------
 include/linux/phy.h            |  5 ++---
 30 files changed, 12 insertions(+), 123 deletions(-)

-- 
2.19.1
