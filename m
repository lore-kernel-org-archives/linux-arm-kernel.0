From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 28 Jan 2016 11:32:11 +0000
Subject: [PATCH 0/6] Support for systems without AArch32 state
Message-ID: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add checks to make sure that the AArch32 state is
supported before we process the 32bit ID registers. Also
checks the same for COMPAT binary execution.

This series applies on top of 4.5-rc1 + Early CPU feature verification [1] +
Handle sign bit for CPU Features [2], even though review
doesn't require going through [1] & [2].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401727.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401913.html

Suzuki K Poulose (6):
  arm64: hwcaps: Cleanup naming
  arm64: HWCAP: Split COMPAT HWCAP table entries
  arm64: Add helpers for detecting AArch32 support at EL0
  arm64: cpufeature: Check availability of AArch32
  arm64: cpufeature: Track 32bit EL0 support
  arm64: compat: Check for AArch32 state

 arch/arm64/include/asm/cpufeature.h |   15 ++-
 arch/arm64/include/asm/elf.h        |    3 +-
 arch/arm64/include/asm/sysreg.h     |    1 +
 arch/arm64/kernel/cpufeature.c      |  186 +++++++++++++++++++++--------------
 arch/arm64/kernel/cpuinfo.c         |   40 ++++----
 5 files changed, 151 insertions(+), 94 deletions(-)

-- 
1.7.9.5
