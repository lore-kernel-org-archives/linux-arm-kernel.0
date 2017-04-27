From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Thu, 27 Apr 2017 17:16:21 +0530
Subject: [PATCH 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
Message-ID: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geetha <gakula@cavium.com>

Cavium CN99xx SMMUv3 implementation has two Silicon Erratas.
1. Errata ID #74
   SMMU register alias Page 1 is not implemented
2. Errata ID #126
   SMMU doesnt support unique IRQ lines for gerror, eventq and cmdq-sync

The following patchset does software workaround for these two erratas.

This series is based on RFC patch.  
https://www.spinics.net/lists/arm-kernel/msg575739.html

As suggested by Will Deacon, code is modified to use silicon id to
enable errata#74 workaround.

Linu Cherian (1):
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #74

Geetha (2):
  arm64: Add MIDR values for Cavium cn99xx SoCs
  iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126

 Documentation/arm64/silicon-errata.txt |  2 ++
 arch/arm64/include/asm/cputype.h       |  3 ++
 drivers/acpi/arm64/iort.c              | 14 +++++++-
 drivers/iommu/arm-smmu-v3.c            | 64 +++++++++++++++++++++++++++++-----
 4 files changed, 73 insertions(+), 10 deletions(-)

-- 
1.9.1
