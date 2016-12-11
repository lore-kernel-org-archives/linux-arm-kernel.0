From: alex.popov@linux.com (Alexander Popov)
Date: Sun, 11 Dec 2016 03:50:54 +0300
Subject: [PATCH 0/2] Make kcov work properly with KASLR enabled
Message-ID: <1481417456-28826-1-git-send-email-alex.popov@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_RANDOMIZE_BASE is enabled, kcov currently reports kernel addresses
including the random offset which breaks the coverage-guided fuzzing on x86_64 and
AArch64. Fix that by subtracting kaslr_offset() return value.

Alexander Popov (2):
  arm64: setup: introduce kaslr_offset()
  kcov: make kcov work properly with KASLR enabled

 arch/arm64/include/asm/setup.h      | 19 +++++++++++++++++++
 arch/arm64/include/uapi/asm/setup.h |  4 ++--
 arch/arm64/kernel/setup.c           |  8 ++++----
 kernel/kcov.c                       |  8 +++++++-
 4 files changed, 32 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/include/asm/setup.h

-- 
2.7.4
