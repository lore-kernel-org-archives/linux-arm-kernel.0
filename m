From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 25 Feb 2015 14:14:54 -0800
Subject: [PATCH 0/3] CONFIG_DEBUG_SET_MODULE_RONX fixups
Message-ID: <1424902497-32141-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

CONFIG_DEBUG_SET_MODULE_RONX is currently non-functional on arm and arm64
because of changes in behavior of is_module_addr. This series fixes
both arm and arm64 to work correctly and corrects a minor bug
related to section alignment in modules.

Laura Abbott (3):
  arm64: Don't use is_module_addr in setting page attributes
  arm: Don't use is_module_addr in setting page attributes
  kernel/module.c: Update debug alignment after symtable generation

 arch/arm/mm/pageattr.c   | 5 ++++-
 arch/arm64/mm/pageattr.c | 5 ++++-
 kernel/module.c          | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
