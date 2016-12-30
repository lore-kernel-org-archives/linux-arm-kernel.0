From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 30 Dec 2016 13:11:27 +0900
Subject: [PATCH v2 0/2] phy: Replace the deprecated extcon API
References: <CGME20161230041136epcas5p4e0229714cd00961e5d3cb5ef9923b7aa@epcas5p4.samsung.com>
Message-ID: <1483071089-8362-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches just replace the deprecated extcon API without any change
of extcon operation and use the resource-managed function for
extcon_register_notifier().

The new extcon API instead of deprecated API.
- extcon_set_cable_state_() -> extcon_set_state_sync();
- extcon_get_cable_state_() -> extcon_get_state();

Changes from v1:
- Rebase these patches based on v4.10-rc1.
- Drop the usb/power-supply/chipidea patches.

Chanwoo Choi (2):
  phy: rcar-gen3-usb2: Replace the deprecated extcon API
  phy: sun4i-usb: Replace the deprecated extcon API

 drivers/phy/phy-rcar-gen3-usb2.c | 8 ++++----
 drivers/phy/phy-sun4i-usb.c      | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1
