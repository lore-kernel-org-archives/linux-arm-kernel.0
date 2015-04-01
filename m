From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Wed, 1 Apr 2015 13:49:06 -0700
Subject: [PATCH v1 0/3] Add devm_of_phy_get_by_index and update platform
 drivers
Message-ID: <1427921349-18173-1-git-send-email-arun.ramamurthy@broadcom.com>
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

Arun Ramamurthy (3):
  phy: core: Add devm_of_phy_get_by_index to phy-core
  usb: ehci-platform: Use devm_of_phy_get_by_index
  usb: ohci-platform: Use devm_of_phy_get_by_index

 drivers/phy/phy-core.c           | 32 ++++++++++++++++++
 drivers/usb/host/ehci-platform.c | 70 ++++++++++++++--------------------------
 drivers/usb/host/ohci-platform.c | 70 ++++++++++++++--------------------------
 include/linux/phy/phy.h          |  2 ++
 4 files changed, 84 insertions(+), 90 deletions(-)

-- 
2.3.4
