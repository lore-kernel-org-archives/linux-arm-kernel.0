From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 5 Jun 2014 21:37:08 +0800
Subject: [PATCH RFC v1 0/2] Add support for Hisilicon SMMU architecture
Message-ID: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is base on arm_smmu.c, beause of hisilicon smmu-v1 is similar to
arm-smmu, some code can be direct reused. for example: map and unmap, device
tree configuration, and the software framework. Somebody may doubted: why not
strip the share code in one file, and put hardware-dependent part into other
files? Yeah, it's right. But now, in order to make the code flow clearly, just
put all hisilicon smmu driver code in hisi_smmu.c.If this driver is acceptable,
I will update and submit a revised verion.

Zhen Lei (2):
  documentation/iommu: Add description of Hisilicon System MMU binding
  iommu/hisilicon: Add support for Hisilicon Ltd. System MMU
    architecture

 .../devicetree/bindings/iommu/hisilicon,smmu.txt   |   70 +
 drivers/iommu/Kconfig                              |   11 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/hisi-smmu.c                          | 1686 ++++++++++++++++++++
 4 files changed, 1768 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt
 create mode 100644 drivers/iommu/hisi-smmu.c

--
1.8.0
