From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Mon, 13 Apr 2015 15:10:44 -0700
Subject: [PATCHv2 0/3] Add devm_of_phy_get_by_index and update platform drivers
Message-ID: <1428963047-23666-1-git-send-email-arun.ramamurthy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a new API to get phy by index when multiple 
phys are present. This patch is based on discussion with Arnd Bergmann
about dt bindings for multiple phys.

History:
v1:
    - Removed null pointers on Dmitry's suggestion
    - Improved documentation in commit messages
    - Exported new phy api
v2:
    - EHCI and OHCI platform Kconfigs select Generic Phy
      to fix build errors in certain configs. 

Arun Ramamurthy (3):
  phy: core: Add devm_of_phy_get_by_index to phy-core
  usb: ehci-platform: Use devm_of_phy_get_by_index
  usb: ohci-platform: Use devm_of_phy_get_by_index

 drivers/phy/phy-core.c           | 32 ++++++++++++++++++
 drivers/usb/host/Kconfig         |  2 ++
 drivers/usb/host/ehci-platform.c | 70 ++++++++++++++--------------------------
 drivers/usb/host/ohci-platform.c | 70 ++++++++++++++--------------------------
 include/linux/phy/phy.h          |  2 ++
 5 files changed, 86 insertions(+), 90 deletions(-)

-- 
2.3.4
