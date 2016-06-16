From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 16 Jun 2016 17:40:29 -0400
Subject: [PATCH 0/6] [media] Fixes and improvements for VIDIOC_QUERYCAP in
 Samsung media drivers
Message-ID: <1466113235-25909-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series contains some fixes and improvements for the VIDIOC_QUERYCAP ioctl
handler in different media platform drivers for IP blocks found in Exynos SoCs.

Some of the issues were reported by the v4l2-compliance tool while others are
things I noticed while looking at the Driver name, Card type and Bus info.

Best regards,
Javier


Javier Martinez Canillas (6):
  [media] s5p-mfc: set capablity bus_info as required by VIDIOC_QUERYCAP
  [media] s5p-mfc: improve v4l2_capability driver and card fields
  [media] s5p-jpeg: set capablity bus_info as required by
    VIDIOC_QUERYCAP
  [media] s5p-jpeg: only fill driver's name in capabilities driver field
  [media] gsc-m2m: add device name sufix to bus_info capatiliby field
  [media] gsc-m2m: improve v4l2_capability driver and card fields

 drivers/media/platform/exynos-gsc/gsc-m2m.c     | 7 ++++---
 drivers/media/platform/s5p-jpeg/jpeg-core.c     | 7 ++++---
 drivers/media/platform/s5p-mfc/s5p_mfc.c        | 1 -
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h | 2 ++
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c    | 7 ++++---
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c    | 7 ++++---
 6 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.5.5
