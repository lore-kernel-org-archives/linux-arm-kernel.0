From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat,  5 Aug 2017 17:40:20 +0300
Subject: [PATCH 0/2] arm64: cleanup {COMPAT_,}SET_PERSONALITY
Message-ID: <20170805144022.17260-1-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is the result of discussion:
https://lkml.org/lkml/2017/7/31/454

First patch introduces MMCF flags for mm_context_t ->flags to separate it from 
TIF ones. And second patch moves personality-related setup code from
SET_PERSONALITY() to the helper.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Pratyush Anand <panand@redhat.com>

Yury Norov (2):
  arm64: introduce separated bits for mm_context_t flags
  arm64: cleanup {COMPAT_,}SET_PERSONALITY() macro

 arch/arm64/include/asm/elf.h         | 15 +++++++++------
 arch/arm64/include/asm/mmu.h         |  2 ++
 arch/arm64/include/asm/thread_info.h |  3 +++
 arch/arm64/kernel/probes/uprobes.c   |  2 +-
 arch/arm64/kernel/process.c          | 17 +++++++++++++++++
 5 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.11.0
