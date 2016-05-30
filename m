From: thommyj@gmail.com (Thommy Jakobsson)
Date: Mon, 30 May 2016 22:40:04 +0200
Subject: [PATCH 0/2] arm-smmu: add master mask
Message-ID: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes it possible to manually set a mask for a master.
Default behaviour when not specifying a mask is to keep current behaviour.
If masks are specified for a master, all of its stream IDs needs to have a
mask.

Platforms with a large number of IDs per master starts to show up. Its
impractical to specify all available IDs in some cases. Specific example
is the ZynqMPSoC, where the streamid have 6 bits from the AXI ID. So 2^6
IDs for each PL port, which there are 6 of.

Thommy Jakobsson (2):
  arm-smmu: doc: add binding for stream ID mask
  arm-smmu: Add possibillity to mask streamIDs

 .../devicetree/bindings/iommu/arm,smmu.txt         | 15 +++++++-
 drivers/iommu/arm-smmu.c                           | 43 +++++++++++++++++++++-
 2 files changed, 55 insertions(+), 3 deletions(-)

-- 
1.9.1
