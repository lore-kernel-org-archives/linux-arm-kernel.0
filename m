From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 31 Jan 2018 14:44:30 +0100
Subject: [RFC PATCH v2 0/5] dt-bindings: add bindings for USB physical
 connector
References: <CGME20180131134456eucas1p2543fb6c96a29c57e991f5de1a4ef89fe@eucas1p2.samsung.com>
Message-ID: <20180131134435.12216-1-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset introduces USB physical connector bindings, together with working example.
I have added comments in relevant patches to describe possible issues.
In v2 I have addressed comments by Rob and Laurent, thanks 
Changes are described in patches.

Regards
Andrzej


Andrzej Hajda (4):
  dt-bindings: add bindings for USB physical connector
  arm64: dts: exynos: add micro-USB connector node to TM2 platforms
  arm64: dts: exynos: add OF graph between MHL and USB connector
  extcon: add possibility to get extcon device by OF node

Maciej Purski (1):
  drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

 .../bindings/connector/usb-connector.txt           | 48 +++++++++++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 37 ++++++++-
 drivers/extcon/extcon.c                            | 44 +++++++---
 drivers/gpu/drm/bridge/sil-sii8620.c               | 97 +++++++++++++++++++++-
 include/linux/extcon.h                             |  6 ++
 5 files changed, 216 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

-- 
2.15.1
