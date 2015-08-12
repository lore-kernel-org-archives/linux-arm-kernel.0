From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 12 Aug 2015 20:17:44 +0530
Subject: [PATCH 0/5] iommu/msm: Add DT adaptation and generic bindings support
Message-ID: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm_iommu.c driver currently works based on platform data. A single master
device can be connected to more than one iommu and multiple contexts in each
of the iommu. This association between master and iommus was represented
from platform data using parent/child devices. The master drivers were
responsible for attaching all of the iommus/context to a domain. Now the
platform data support is removed and DT support is added. The master/iommus
are added through generic iommu bindings.

This is essentially rework of the patch posted earlier by
Rob Clark <robdclark@gmail.com>. This series folds the changes
in to the existing driver with the addition of generic bindings.

        http://www.spinics.net/lists/linux-arm-msm/msg10077.html

This series is based on the IOMMU probe deferral series from
Laurent Pinchart <laurent.pinchart@ideasonboard.com>

        https://lkml.org/lkml/2015/5/14/786

Tested this series on ifc6410 board.

Sricharan R (5):
  iommu/msm: Add DT adaptation
  iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
  iommu/msm: Add support for generic master bindings
  iommu/msm: Set cacheability attributes without tex remap
  iommu/msm: Remove driver BROKEN

 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  59 +++
 drivers/iommu/Kconfig                              |   1 -
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/msm_iommu.c                          | 508 ++++++++++++++-------
 drivers/iommu/msm_iommu.h                          |  73 ++-
 drivers/iommu/msm_iommu_dev.c                      | 392 ----------------
 drivers/iommu/msm_iommu_hw-8xxx.h                  |  10 +-
 7 files changed, 432 insertions(+), 613 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 delete mode 100644 drivers/iommu/msm_iommu_dev.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
