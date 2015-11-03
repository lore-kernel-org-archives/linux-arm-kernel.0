From: labbott@fedoraproject.org (Laura Abbott)
Date: Tue,  3 Nov 2015 13:48:33 -0800
Subject: [PATCH 0/2] Support for set_memory_* outside of module space
Message-ID: <1446587315-18145-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Based on a recent discussion[1] there is interest in having set_memory_* work
on kernel memory for security and other use cases. This patch adds the
ability for that to happen behind a kernel option. If this is welcome enough,
the Kconfig can be dropped. This has been briefly tested but not stress tested.

Thanks,
Laura

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/382079.html

Laura Abbott (2):
  arm64: Get existing page protections in split_pmd
  arm64: Allow changing of attributes outside of modules

 arch/arm64/Kconfig.debug | 11 +++++++
 arch/arm64/mm/mm.h       |  3 ++
 arch/arm64/mm/mmu.c      | 11 ++++---
 arch/arm64/mm/pageattr.c | 74 ++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 88 insertions(+), 11 deletions(-)

-- 
2.4.3
