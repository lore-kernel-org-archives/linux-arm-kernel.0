From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 16 Jan 2017 21:36:56 +0900
Subject: [PATCH v3 0/6] usb: Replace the deprecated extcon API
References: <CGME20170116123713epcas1p1d9f40f277e83cb46b9a9333fe2704fb9@epcas1p1.samsung.com>
Message-ID: <1484570222-30522-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches just replace the deprecated extcon API without any change
of extcon operation and use the resource-managed function for
extcon_register_notifier().

The new extcon API instead of deprecated API.
- extcon_set_cable_state_() -> extcon_set_state_sync();
- extcon_get_cable_state_() -> extcon_get_state();

Changes from v2:
- Rebase these patches based on usb.git[1] (testing/next branch)

Changes from v1:
- Rebase these patches based on v4.10-rc1.
- Add acked-by tag from usb maintainer and reviewer.
- Drop the phy/power-supply/chipidea patches.

[1] https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=testing/next

Chanwoo Choi (6):
  usb: dwc3: omap: Replace the extcon API
  usb: phy: msm: Replace the extcon API
  usb: phy: omap-otg: Replace the extcon API
  usb: phy: qcom-8x16-usb: Replace the extcon API
  usb: phy: tahvo: Replace the deprecated extcon API
  usb: renesas_usbhs: Replace the deprecated extcon API

 drivers/usb/dwc3/dwc3-omap.c        | 20 +++++++-------------
 drivers/usb/phy/phy-msm-usb.c       | 33 +++++++++++----------------------
 drivers/usb/phy/phy-omap-otg.c      | 24 ++++++------------------
 drivers/usb/phy/phy-qcom-8x16-usb.c | 13 ++++---------
 drivers/usb/phy/phy-tahvo.c         | 10 +++++-----
 drivers/usb/renesas_usbhs/common.c  |  2 +-
 6 files changed, 34 insertions(+), 68 deletions(-)

-- 
1.9.1
