From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 24 Feb 2016 07:02:30 +0800
Subject: [PATCH 0/2] MT8173 IOMMU 4GB MODE SUPPORT
Message-ID: <1456268552-16635-1-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This patch-set add MTK 4GB mode support on the Short-Descriptor.
MTK extend the bit9 of the standard pgtable descriptor as the 4GB mode.
We add a special quirk for this.
  This two patches are based on Robin's Short-decriptor v3[1], MTK
IOMMU v10[2] and Robin's "Rationalise quirk handling"[3].

[1]: http://lists.linuxfoundation.org/pipermail/iommu/2016-January/015463.html
[2]: http://lists.linuxfoundation.org/pipermail/iommu/2016-February/015795.html
[3]: http://lists.linuxfoundation.org/pipermail/iommu/2016-February/015663.html

Yong Wu (2):
  iommu/io-pgtable: Add MTK 4GB mode in Short-descriptor
  iommu/mediatek: Add 4GB mode support

 drivers/iommu/io-pgtable-arm-v7s.c | 14 +++++++++++++-
 drivers/iommu/io-pgtable.h         |  6 ++++++
 drivers/iommu/mtk_iommu.c          | 14 +++++++++++---
 3 files changed, 30 insertions(+), 4 deletions(-)

-- 
1.8.1.1.dirty 
