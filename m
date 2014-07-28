From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 28 Jul 2014 15:22:45 +0800
Subject: [PATCH v4 0/3] media: atmel-isi: Add DT support for Atmel ISI driver
Message-ID: <1406532167-32655-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add DT support for atmel ISI driver. It can support the
common v4l2 DT interfaces.

v3 -> v4:
  if bus-width set to 10, then we support both 8 bits and 10 bits.
  misc fix according to Guennadi.

v2 -> v3:
  support bus-width property for atmel-isi endpoint.

v1 -> v2:
  modified the device tree binding document to remove an optonal property.

Josh Wu (3):
  atmel-isi: add v4l2 async probe support
  atmel-isi: convert the pdata from pointer to structure
  atmel-isi: add primary DT support

 .../devicetree/bindings/media/atmel-isi.txt        | 51 ++++++++++++
 drivers/media/platform/soc_camera/atmel-isi.c      | 90 +++++++++++++++++++---
 include/media/atmel-isi.h                          |  4 +
 3 files changed, 133 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/atmel-isi.txt

-- 
1.9.1
