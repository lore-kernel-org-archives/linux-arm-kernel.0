From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 13 Jul 2017 18:15:59 +0100
Subject: [PATCH 0/2] md/raid6: improvements for ARM/arm64
Message-ID: <20170713171601.25440-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Use a faster algorithm for the delta syndrome
2. Implement recovery routines in NEON

As before, NEON intrinsics are used, which means the same code can be
compiled for ARM as well as arm64.

Given that there does not seem to be a maintainer for lib/raid6, could
we take this through one of the ARM trees instead?

Ard Biesheuvel (2):
  md/raid6: use faster multiplication for ARM NEON delta syndrome
  md/raid6: implement recovery using ARM NEON intrinsics

 include/linux/raid/pq.h      |   1 +
 lib/raid6/Makefile           |   4 +-
 lib/raid6/algos.c            |   3 +
 lib/raid6/neon.uc            |  33 +++++-
 lib/raid6/recov_neon.c       | 110 ++++++++++++++++++
 lib/raid6/recov_neon_inner.c | 117 ++++++++++++++++++++
 6 files changed, 264 insertions(+), 4 deletions(-)
 create mode 100644 lib/raid6/recov_neon.c
 create mode 100644 lib/raid6/recov_neon_inner.c

-- 
2.9.3
