From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 17 Feb 2016 10:41:12 -0600
Subject: [PATCH v2 0/2] arm64: mm: Mark .rodata as RO
Message-ID: <1455727274-16328-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the .rodata section is actually still executable when DEBUG_RODATA
is enabled. This changes that so the .rodata is actually read only, no execute.

This patch is based on top of "PATCH v2 flag contiguous PTES in linear mapping"

V1->V2
  Added .rodata to kernel VM range notice in mem_init
  Split _stext->_etext into an additional chunk in map_kernel

Jeremy Linton (2):
  arm64: mm: Mark .rodata as RO
  arm64/mm: Add .rodata to kernel virtual memory boot notice

 arch/arm64/kernel/vmlinux.lds.S |  5 +++--
 arch/arm64/mm/init.c            |  4 +++-
 arch/arm64/mm/mmu.c             | 17 +++++++++++++----
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.4.3
