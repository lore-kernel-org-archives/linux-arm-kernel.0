From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Jan 2016 10:58:12 +0000
Subject: [PATCH 0/4] arm64: cpufeature: Fix sign of feature bits
Message-ID: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM ARM is getting updated with the guidelines on how to treat the
feature values for their sign. This series fixes the handling of sign
based on the new update. Also make the capabilities aware of the sign
of the feature to use the appropriate helper for extracting the values.

See Patch2 for more details on the rules.


Suzuki K. Poulose (4):
  arm64: cpufeature: Correct feature register tables
  arm64: cpufeature: Fix the sign of feature bits
  arm64: capabilities: Handle sign of the feature bit
  arm64: Rename cpuid_feature field extract routines

 arch/arm64/include/asm/cpufeature.h |   29 +++++++----
 arch/arm64/include/asm/kvm_mmu.h    |    2 +-
 arch/arm64/kernel/cpufeature.c      |   96 ++++++++++++++++++++---------------
 arch/arm64/kernel/debug-monitors.c  |    2 +-
 arch/arm64/kvm/sys_regs.c           |    2 +-
 arch/arm64/mm/context.c             |    2 +-
 6 files changed, 78 insertions(+), 55 deletions(-)

-- 
1.7.9.5
