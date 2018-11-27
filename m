From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 12:41:54 +0000
Subject: [PATCH 0/3] arm64: Add support for speculation barrier instruction
 (SB)
Message-ID: <1543322517-470-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

As part of the fallout from specdown and meltre, Armv8.5 introduces an
architected Speculation Barrier (SB) instruction. Unlike CSDB, this is
not retrofitted to existing CPUs, so we need to plumb in an HWCAP and
make use of the alternatives framework to patch it over our current
DSB; ISB sequence on CPUs that support it.

Cheers,

Will

--->8

Will Deacon (3):
  arm64: Add support for SB barrier and patch in over DSB; ISB sequences
  arm64: entry: Place an SB sequence following an ERET instruction
  arm64: entry: Remove confusing comment

 arch/arm64/include/asm/assembler.h  | 13 +++++++++++++
 arch/arm64/include/asm/barrier.h    |  4 ++++
 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/sysreg.h     |  6 ++++++
 arch/arm64/include/asm/uaccess.h    |  3 +--
 arch/arm64/include/uapi/asm/hwcap.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 12 ++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  1 +
 arch/arm64/kernel/entry.S           |  6 ++----
 arch/arm64/kvm/hyp/entry.S          |  1 +
 arch/arm64/kvm/hyp/hyp-entry.S      |  4 ++++
 11 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.1.4
