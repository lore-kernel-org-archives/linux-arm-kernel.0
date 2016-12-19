From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 19 Dec 2016 16:05:35 +0100
Subject: [PATCH net 0/3] Fix integration of eee-broken-modes
Message-ID: <1482159938-13239-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this series is to fix the integration of the ethernet phy
property "eee-broken-modes" [0]

The v3 of this series has been merged, missing a fix (error reported by
kbuild robot) available in the v4 [1]

More importantly, Florian opposed adding a DT property mapping a device
register this directly [2]. The concern was that the property could be
abused to implement platform configuration policy. After discussing it,
I think we agreed that such information about the HW (defect) should appear
in the platform DT. However, the preferred way is to add a boolean property
for each EEE broken mode.

[0]: http://lkml.kernel.org/r/1480326409-25419-1-git-send-email-jbrunet at baylibre.com
[1]: http://lkml.kernel.org/r/1480348229-25672-1-git-send-email-jbrunet at baylibre.com
[2]: http://lkml.kernel.org/r/e14a3b0c-dc34-be14-48b3-518a0ad0c080 at gmail.com

Jerome Brunet (3):
  net: phy: fix sign type error in genphy_config_eee_advert
  net: phy: use boolean dt properties for eee broken modes
  dt: bindings: net: use boolean dt properties for eee broken modes

 Documentation/devicetree/bindings/net/phy.txt | 10 ++++++++--
 drivers/net/phy/phy_device.c                  | 22 +++++++++++++++++-----
 include/dt-bindings/net/mdio.h                | 19 -------------------
 3 files changed, 25 insertions(+), 26 deletions(-)
 delete mode 100644 include/dt-bindings/net/mdio.h

-- 
2.7.4
