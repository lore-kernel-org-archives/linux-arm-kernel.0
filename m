From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Jun 2012 17:22:35 +0100
Subject: [PATCH v2 0/2] Implement word-at-a-time string functions for ARM
Message-ID: <1339777357-32479-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version 2 of the patches originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/103290.html

There are only cosmetic changes from v1:
	- Added Nico's reviewed-by tags
	- Removed RFC prefix
	- Fixed changelog to echo the fact that we may use clz

I'm still interested in any pathname-heavy benchmarks that people may
have to stress the name hashing code. My simple find test does show an
improvement but I don't know how realistic that is.

Cheers,

Will


Will Deacon (2):
  ARM: use generic strnlen_user and strncpy_from_user functions
  ARM: dcache: select DCACHE_WORD_ACCESS for little-endian ARMv6+ CPUs

 arch/arm/Kconfig                      |    3 +
 arch/arm/include/asm/uaccess.h        |   27 ++-------
 arch/arm/include/asm/word-at-a-time.h |   96 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/armksyms.c            |    4 --
 arch/arm/lib/Makefile                 |    1 -
 arch/arm/lib/strncpy_from_user.S      |   43 ---------------
 arch/arm/lib/strnlen_user.S           |   40 --------------
 7 files changed, 105 insertions(+), 109 deletions(-)
 create mode 100644 arch/arm/include/asm/word-at-a-time.h
 delete mode 100644 arch/arm/lib/strncpy_from_user.S
 delete mode 100644 arch/arm/lib/strnlen_user.S

-- 
1.7.4.1
