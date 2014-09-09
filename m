From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Tue,  9 Sep 2014 15:26:54 +0530
Subject: [PATCH 0/5] UIO driver for APM X-Gene QMTM
Message-ID: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables user space access to APM X-Gene QMTM
using UIO framework.

The patchset also introduces new type UIO_MEM_PHYS_CACHE
for mem regions because APM X-Gene QMTM device supports
cache coherency with CPU caches.

Ankit Jindal (5):
  uio: Add new UIO_MEM_PHYS_CACHE type for mem regions
  Documentation: Update documentation for UIO_MEM_PHYS_CACHE
  drivers: uio: Add Xgene QMTM UIO driver
  dt-bindings: Add binding info for Xgene QMTM UIO driver
  MAINTAINERS: Add entry for APM Xgene QMTM UIO driver

 Documentation/DocBook/uio-howto.tmpl               |    3 +-
 .../devicetree/bindings/uio/uio_xgene_qmtm.txt     |   45 +++
 MAINTAINERS                                        |    7 +
 drivers/uio/Kconfig                                |    8 +
 drivers/uio/Makefile                               |    1 +
 drivers/uio/uio.c                                  |   22 +-
 drivers/uio/uio_xgene_qmtm.c                       |  289 ++++++++++++++++++++
 include/linux/uio_driver.h                         |    7 +-
 8 files changed, 369 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/uio/uio_xgene_qmtm.txt
 create mode 100644 drivers/uio/uio_xgene_qmtm.c

-- 
1.7.9.5
