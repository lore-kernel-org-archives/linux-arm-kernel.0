From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 12 Aug 2014 16:37:45 -0700
Subject: [PATCHv3 0/2] arm64 CONFIG_DEBUG_SET_MODULE_RONX support
Message-ID: <1407886667-16919-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This adds support for CONFIG_DEBUG_SET_MODULE_RONX for arm64. The last version
was added as part of a series to add RWX permissions for the rest of memory[1].
That series still needs quite a bit of work though so I'm submitting this
separately.

Thanks,
Laura

v3: Addressed comments by Will/Steve

Laura Abbott (2):
  arm64: Introduce {set,clear}_pte_bit
  arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support

 arch/arm64/Kconfig.debug            |  11 ++++
 arch/arm64/include/asm/cacheflush.h |   4 ++
 arch/arm64/include/asm/pgtable.h    |  33 +++++-----
 arch/arm64/mm/Makefile              |   2 +-
 arch/arm64/mm/pageattr.c            | 118 ++++++++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/mm/pageattr.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
