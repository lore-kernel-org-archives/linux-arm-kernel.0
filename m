From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  7 Aug 2018 09:54:04 +0100
Subject: [PATCH 0/2] iommu/rockchip: Runtime PM fixes
Message-ID: <20180807085406.3863-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series addresses a couple of runtime PM issues I've spotted
while running 4.18 on a Chromebook Plus (kevin, rk3399) platform, and
specifically doing kexec.

Note that even with these two patches, kexec is still fairly broken on
rk3399, as the VOP is never turned off (see [1] for a fix).

[1] https://www.spinics.net/lists/arm-kernel/msg670229.html

Marc Zyngier (2):
  iommu/rockchip: Handle errors returned from PM framework
  iommu/rockchip: Move irq request past pm_runtime_enable

 drivers/iommu/rockchip-iommu.c | 45 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 17 deletions(-)

-- 
2.18.0
