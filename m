From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 8 Jul 2015 14:27:43 +0300
Subject: [PATCH 0/5] Host1x/TegraDRM fixes/improvements
Message-ID: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, this series has a few small improvements for Host1x and TegraDRM
that the VIC series will build upon.

1/5 is a bug fix to host1x.
2/5 is required by VIC code to implement ->is_addr_reg().
3/5 deduplicates handling of HOST1X class address registers
    and fixes the checked registers.
4/5 is required for the host1x firewall to work when bo's are
    mapped using IOMMU.
5/5 adds a TegraDRM allocator that allows drivers to allocate
    non-GEM memory that is still mapped to the TegraDRM domain.

Arto Merilainen (3):
  host1x: Store device address to all bufs
  host1x: Pass register value in firewall
  drm/tegra: Support kernel mappings with IOMMU

Mikko Perttunen (2):
  host1x: Handle HOST1X class address registers directly
  drm/tegra: Add Tegra DRM allocation API

 drivers/gpu/drm/tegra/drm.c  | 99 +++++++++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/tegra/drm.h  | 13 +++++-
 drivers/gpu/drm/tegra/gem.c  | 34 +++++++++++++--
 drivers/gpu/drm/tegra/gr2d.c | 25 ++++-------
 drivers/gpu/drm/tegra/gr3d.c | 24 ++++-------
 drivers/gpu/host1x/job.c     | 54 +++++++++++++++++-------
 include/linux/host1x.h       |  4 +-
 7 files changed, 193 insertions(+), 60 deletions(-)

-- 
2.1.4
