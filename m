From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Fri,  2 Mar 2018 14:55:28 +0000
Subject: [PATCH 0/3] drivers: rpmsg: make rpmsg bus DMA capable
Message-ID: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Qualcomm SoCs, DSP exposes many functionalities like audio,
as these drivers are child of rpmsg bus. Any dma allocations
or iommu operations on these devices would fail as the rpmsg
bus is not marked as dma capable bus.

This patchset makes the rpmsg bus dma capable.

This patchset is tested on DB410c and DB820c boards.

Thanks,
srini

Srinivas Kandagatla (3):
  rpmsg: core: export rpmsg bus type
  rpmsg: core: make rpmsg bus DMA capable
  iommu: armsmmu: set iommu ops for rpmsg bus

 drivers/iommu/arm-smmu.c   | 5 +++++
 drivers/rpmsg/rpmsg_core.c | 4 +++-
 include/linux/rpmsg.h      | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.15.1
