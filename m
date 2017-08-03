From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 03 Aug 2017 17:20:43 +0900
Subject: [PATCH v2 0/5] usb: Replace the deprecated extcon API
References: <CGME20170803082049epcas1p3ca6cb415ce40b24fa360f7155ea0829c@epcas1p3.samsung.com>
Message-ID: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches replace the deprecated extcon API and remove them from extcon.

Patch4 (drivers/usb/gadget/udc/snps_udc_plat.c) neeeds the review
from usb maintainer. After finishing the review of patch4,
I'll create the immutable branch and send the pull request
to both usb and phy maintainer.

Changes from v1:
- Fix capital error for 'acked-by' tag on patch2
- Add the acked-by tag of 'Kishon Vijay Abraham I' to patch3

Chanwoo Choi (5):
  phy: qcom-usb-hs: Replace the extcon API
  phy: rockchip-inno-usb2: Replace the extcon API
  phy: phy-bcm-ns2-usbdrd: Replace the deprecated extcon API
  usb: gadget: udc: Replace the deprecated extcon API
  extcon: Remove deprecated extcon_set/get_cable_state_()

 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |  8 ++++----
 drivers/phy/qualcomm/phy-qcom-usb-hs.c        | 14 +++-----------
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 10 +++++-----
 drivers/usb/gadget/udc/snps_udc_plat.c        |  6 +++---
 include/linux/extcon.h                        | 11 -----------
 5 files changed, 15 insertions(+), 34 deletions(-)

-- 
1.9.1
