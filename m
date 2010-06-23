From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jun 2010 16:02:16 +0100
Subject: [PATCH 0/2] Fix atomic operations so that atomic64_test passes on ARM
Message-ID: <1277305338-26110-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recently introduced Kernel feature is the atomic64_test on boot.
ARM fails these tests because the compiler is not correctly informed about
updates occuring to memory and is at liberty to constant-fold atomic64_t
variables.

This patch series adds the correct memory constraints to the atomic operations
on ARM and also enables all of the atomic64 tests in atomic64_test.c.

Will Deacon (2):
  ARM: atomic ops: add memory constraints to inline asm
  ARM: atomic64_test: add ARM as supported architecture

 arch/arm/include/asm/atomic.h |  123 +++++++++++++++++++++--------------------
 lib/atomic64_test.c           |    2 +-
 2 files changed, 63 insertions(+), 62 deletions(-)
