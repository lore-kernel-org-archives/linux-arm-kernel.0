From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 16 Nov 2016 12:07:34 +0100
Subject: [PATCH v5 0/2]  platform: Add DT support for DA8xx
Message-ID: <1479294456-7942-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add and enable the usb otg for da850 and da850-lcdk.
This series depends on "driver: dd DT support for DA8xx" patch set.

If this series is applied before the "usb: musb: da8xx: Fix few issues" patch
set then the usb driver will always retrun -ENODEV.

Changes in v2:
* Remove unrelated changes in patch 3
* Rename the device node in patch 4

Changes in v3:
* Fix few mistakes in DT binding sample
* Only build the device table if DT is enabled

Change in v4:
* Fix a nit

Changes in v5:
* Remove usb_phy node from d850.dtsi because it has already been merged.
* Separated the patch in two: one for the board and one for the SoC.

Alexandre Bailon (2):
  ARM: dts: da850: Add the usb otg device node
  ARM: dts: da850-lcdk: Enable the usb otg device node

 arch/arm/boot/dts/da850-lcdk.dts |  8 ++++++++
 arch/arm/boot/dts/da850.dtsi     | 10 ++++++++++
 2 files changed, 18 insertions(+)

-- 
2.7.3
