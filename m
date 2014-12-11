From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 11 Dec 2014 15:35:34 +0800
Subject: [v3][PATCH 0/5] media: ov2640: add device tree support
Message-ID: <1418283339-16281-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add device tree support for ov2640. And also add
the document for the devicetree properties.

v2->v3:
  1. fix the gpiod_xxx api usage as we use reset pin as ACTIVE_LOW.
  2. update the devicetree binding document.

v1 -> v2:
  1.  modified the dt bindings according to Laurent's suggestion.
  2. add a fix patch for soc_camera. Otherwise the .reset() function won't work.

Josh Wu (5):
  media: soc-camera: use icd->control instead of icd->pdev for reset()
  media: ov2640: add async probe function
  media: ov2640: add primary dt support
  media: ov2640: add a master clock for sensor
  media: ov2640: dt: add the device tree binding document

 .../devicetree/bindings/media/i2c/ov2640.txt       |  53 ++++++++
 drivers/media/i2c/soc_camera/ov2640.c              | 141 ++++++++++++++++++---
 drivers/media/platform/soc_camera/soc_camera.c     |   8 +-
 3 files changed, 182 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov2640.txt

-- 
1.9.1
