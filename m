From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 26 Jan 2016 09:23:39 +0000
Subject: [PATCH 0/4] Update cpu feature extraction
Message-ID: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This has been started as a fix in cpu feature extractor, but Suzuki suggested
syncing-up the whole cpu feature handling with the recent updates on arm64
side [1,2].

I've kept fixes separately, so they can go as the are in case there is concern
on updating cpu feature handling.

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/455568
[2] https://lkml.org/lkml/2015/11/18/570

Thanks!

Vladimir Murzin (4):
  ARM: fix demoting HWCAP_SWP
  ARM: fix cpu feature extracting helper
  ARM: introduce cpu feature helper for unsigned values
  ARM: use proper helper while extracting cpu features

 arch/arm/include/asm/cputype.h  |   16 +++++++++++++---
 arch/arm/include/asm/smp_plat.h |    4 ++--
 arch/arm/kernel/setup.c         |   34 ++++++++++++++++++++--------------
 arch/arm/kernel/thumbee.c       |    4 +---
 arch/arm/mm/mmu.c               |    2 +-
 5 files changed, 37 insertions(+), 23 deletions(-)

-- 
1.7.9.5
