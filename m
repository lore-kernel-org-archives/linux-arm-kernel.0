From: labbott@fedoraproject.org (Laura Abbott)
Date: Tue, 10 Nov 2015 17:57:35 -0800
Subject: [PATCHv2 0/2] Support for set_memory_* outside of module space
Message-ID: <1447207057-11323-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of the series to allow set_memory_* to work on kernel memory
for security and other use cases. Should have addressed most comments
although another look might be necessary for the contiguous bit.

Thanks,
Laura

Laura Abbott (2):
  arm64: Get existing page protections in split_pmd
  arm64: Allow changing of attributes outside of modules

 arch/arm64/Kconfig       |  12 ++++
 arch/arm64/mm/mm.h       |   3 +
 arch/arm64/mm/mmu.c      |  12 ++--
 arch/arm64/mm/pageattr.c | 174 +++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 174 insertions(+), 27 deletions(-)

-- 
2.5.0
