From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  4 Oct 2018 09:33:12 +0100
Subject: [PATCH 0/3] arm64: cpufeature: Fix handling of CTR_EL0
Message-ID: <20181004083315.31174-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes sure that we handle the CTR_EL0 field mismatches
properly, especially for the IDC field. Also, skip trapping CTR
accesses on a CPU if it matches the safe value.

Applies on arm64 for-next/core

Suzuki K Poulose (3):
  arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
  arm64: cpufeature: Fix handling of CTR_EL0.IDC field
  arm64: cpufeature: Trap CTR_EL0 access only where it is necessary

 arch/arm64/include/asm/cache.h | 40 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c | 17 ++++++++++++---
 arch/arm64/kernel/cpufeature.c | 35 +++++++++++++++++++++++++----
 arch/arm64/kernel/cpuinfo.c    | 10 ++++++++-
 4 files changed, 94 insertions(+), 8 deletions(-)

-- 
2.19.0
