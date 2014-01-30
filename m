From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 30 Jan 2014 19:18:03 +0100
Subject: [PATCH 0/6] iommu/arm-smmu: Misc modifications to support SMMUs on
 Calxeda ECX-2000
Message-ID: <1391105889-32718-1-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v5 of my arm-smmu changes (to support SMMUs on Calxeda ECX-2000).

Patches are based on v3.13.

Changes to previous version are
- use iommu_group notifier instead of bus notifier
- remove superfluous call to arm_smmu_add_device in
  notifier function
- free bitmap that's used for checking of duplicate stream IDs
- hopefully addressed all issues for the "SMR allocator" patch
  (see http://marc.info/?l=linux-arm-kernel&m=139040446813960)
- reorder patches to put the notifier change last (in case there are
  still objections to this the rest could be merged I think)


I omitted the patches that are device-tree related (of, dts,
documentation) or ARM dma-mapping.c related. I'll work on an update of
the dma-mapping change (to automatically increase the mapping size)
separately.

Changelog:
v4:
  http://marc.info/?l=linux-arm-kernel&m=138988209913055
v3:
  http://marc.info/?l=linux-arm-kernel&m=138212725606348
v2:
  http://marc.info/?l=linux-arm-kernel&m=138135834704855
v1:
   http://marc.info/?l=linux-arm-kernel&m=138122450023564


Regards,
Andreas
