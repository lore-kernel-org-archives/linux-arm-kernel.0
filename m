From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Fri, 20 Mar 2015 14:07:07 -0700
Subject: [PATCH 0/3] Add devm_of_phy_get_by_index and update platform drivers
Message-ID: <1426885630-32429-1-git-send-email-arun.ramamurthy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a new API to get phy by index when multiple 
phys are present. This patch is based on discussion with Arnd Bergmann
about dt bindings for multiple phys. 

Arun Ramamurthy (3):
  phy: core: Add devm_of_phy_get_by_index to phy-core
  usb: ehci-platform: Use devm_of_phy_get_by_index
  usb: ohci-platform: Use devm_of_phy_get_by_index

 drivers/phy/phy-core.c           | 30 ++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-platform.c | 20 ++++----------------
 drivers/usb/host/ohci-platform.c | 20 ++++----------------
 include/linux/phy/phy.h          |  2 ++
 4 files changed, 40 insertions(+), 32 deletions(-)

-- 
2.3.2
