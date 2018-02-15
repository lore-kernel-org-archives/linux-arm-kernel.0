From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 15 Feb 2018 11:39:14 +0100
Subject: [RFC PATCH v2 0/6] dt-bindings: add bindings for USB physical
 connector
References: <CGME20180215103925eucas1p1f2278a69a7d81b6ba1ae3583d11e1997@eucas1p1.samsung.com>
Message-ID: <20180215103920.32017-1-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for reviews of previous iterations.

This patchset introduces USB physical connector bindings, together with working example.

v2: I have addressed comments by Rob and Laurent, thanks 
v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C example.

Changes are also described in patches.

Regards
Andrzej


Andrzej Hajda (5):
  dt-bindings: add bindings for USB physical connector
  dt-bindings: add bindings for Samsung micro-USB 11-pin connector
  arm64: dts: exynos: add micro-USB connector node to TM2 platforms
  arm64: dts: exynos: add OF graph between MHL and USB connector
  extcon: add possibility to get extcon device by OF node

Maciej Purski (1):
  drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

 .../connector/samsung,usb-connector-11pin.txt      | 51 ++++++++++++
 .../bindings/connector/usb-connector.txt           | 74 +++++++++++++++++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 38 ++++++++-
 drivers/extcon/extcon.c                            | 44 +++++++---
 drivers/gpu/drm/bridge/sil-sii8620.c               | 97 +++++++++++++++++++++-
 include/linux/extcon.h                             |  6 ++
 6 files changed, 294 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

-- 
2.16.1
