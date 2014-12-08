From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 8 Dec 2014 19:29:02 +0800
Subject: [PATCH 0/5] media: ov2640: add device tree support
Message-ID: <1418038147-13221-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add device tree support for ov2640. And also add
the document for the devicetree properties.

v1 -> v2:
  1.  modified the dt bindings according to Laurent's suggestion.
  2. add a fix patch for soc_camera. Otherwise the .reset() function won't work.

Josh Wu (5):
  media: soc-camera: use icd->control instead of icd->pdev for reset()
  media: ov2640: add async probe function
  media: ov2640: add primary dt support
  media: ov2640: add a master clock for sensor
  media: ov2640: dt: add the device tree binding document

 .../devicetree/bindings/media/i2c/ov2640.txt       |  44 +++++++
 drivers/media/i2c/soc_camera/ov2640.c              | 140 ++++++++++++++++++---
 drivers/media/platform/soc_camera/soc_camera.c     |  10 +-
 3 files changed, 173 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov2640.txt

-- 
1.9.1
