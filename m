From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 27 Feb 2018 08:11:28 +0100
Subject: [PATCH v5 0/6] dt-bindings: add bindings for USB physical connector
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
Message-ID: <20180227071134.28063-1-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for reviews of previous iterations.

This patchset introduces USB physical connector bindings, together with
working example.
I have removed RFC prefix - the patchset seems to be heading
to a happy end :)

v5: fixed extra parenthesis in dts, renamed extcon function.
v4: improved binding descriptions, added missing reg in dts.
v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
    example.
v2: I have addressed comments by Rob and Laurent, thanks 

Changes in datail are described in the patches.

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

 .../connector/samsung,usb-connector-11pin.txt      | 49 +++++++++++
 .../bindings/connector/usb-connector.txt           | 75 +++++++++++++++++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 38 ++++++++-
 drivers/extcon/extcon.c                            | 44 +++++++---
 drivers/gpu/drm/bridge/sil-sii8620.c               | 97 +++++++++++++++++++++-
 include/linux/extcon.h                             |  6 ++
 6 files changed, 293 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

-- 
2.16.2
