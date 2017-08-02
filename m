From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 2 Aug 2017 15:17:21 -0500
Subject: [PATCH 0/3] ARM: dts: k2g: Add support for USB instances on 66AK2G
Message-ID: <20170802201724.11439-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for 66AK2G usb instances. However, the driver needs to be updated
to support PM_RUNTIME. This update has been validated to work on K2L and boot
tested on K2HK and K2E.

Franklin S Cooper Jr (2):
  usb: dwc3: keystone: Add PM_RUNTIME Support to DWC3 Keystone USB
    driver
  dt-bindings: usb: keystone-usb: Update bindings pm and clocks
    properties

Vitaly Andrianov (1):
  ARM: dts: k2g: Add USB instances

 .../devicetree/bindings/usb/keystone-usb.txt       | 18 ++++++-
 arch/arm/boot/dts/keystone-k2g.dtsi                | 56 ++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-keystone.c                   | 22 ++++-----
 3 files changed, 82 insertions(+), 14 deletions(-)

-- 
2.9.4.dirty
