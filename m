From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Wed, 27 Nov 2013 13:04:23 +0530
Subject: [RFC PATCH 0/2] arm64: Add support for 48-bit Physical Addresses 
Message-ID: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch series provides an implementation of supporting 48-bit
Physical Addresses for ARMv8 platforms. It is the maximum width that
any ARMv8 based processor can support. 

The implementation extends the existing support of 40-bit PA.The kernel
and user space will now be able to access 128TB each. With 4KB page size
the Linux now will be using 4 levels of page tables by making use of
'pud'. And with 64KB page size the Linux will be using 3 levels of page
tables.

The code has been tested with LTP.

Radha Mohan Chintakuntla (2):
  arm64: Add support for 48-bit Physical Addresses
  arm64: Add 48-bit PA support for 64KB page size

 arch/arm64/include/asm/memory.h               |    6 +--
 arch/arm64/include/asm/page.h                 |    4 +-
 arch/arm64/include/asm/pgalloc.h              |   20 ++++++-
 arch/arm64/include/asm/pgtable-3level-hwdef.h |   34 ++++++++++++
 arch/arm64/include/asm/pgtable-4level-hwdef.h |   57 ++++++++++++++++++++
 arch/arm64/include/asm/pgtable-4level-types.h |   71 +++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |    9 ++--
 arch/arm64/include/asm/pgtable.h              |   50 +++++++++++++++---
 arch/arm64/include/asm/tlb.h                  |    2 -
 arch/arm64/kernel/head.S                      |   55 +++++++++++++++++--
 arch/arm64/kernel/traps.c                     |    7 +++
 arch/arm64/mm/proc.S                          |    2 +-
 12 files changed, 289 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/include/asm/pgtable-4level-hwdef.h
 create mode 100644 arch/arm64/include/asm/pgtable-4level-types.h
