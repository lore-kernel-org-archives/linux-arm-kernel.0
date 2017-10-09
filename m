From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Oct 2017 13:55:31 +0100
Subject: [PATCH 0/3] Support Common Not Private translations
Message-ID: <1507553734-27854-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common Not Private (CNP) translations is a feature of ARMv8.2
extension which allows translation table entries to be shared between
different PEs in the same inner shareable domain, so the hardware can
use this fact to optimise the caching of such entries in the TLB.

This patch set is an attempt to bring CNP support into Linux. It was
tested on a v8.2 Fast Model with exploring traces and checking that
TTBRx_ELy and VTTBR_EL2 have CnP bit set where appropriate.

Changelog:

	RFC -> v1
            - dropped RFC tag
            - rebased on 4.14-rc4

Thanks!

Vladimir Murzin (3):
  arm64: mm: Support Common Not Private translations
  arm64: KVM: Support Common Not Private translations
  arm64: Introduce command line parameter to disable CNP

 Documentation/admin-guide/kernel-parameters.txt |  4 +++
 arch/arm64/Kconfig                              | 13 +++++++++
 arch/arm64/include/asm/asm-uaccess.h            |  2 ++
 arch/arm64/include/asm/cpucaps.h                |  3 +-
 arch/arm64/include/asm/cpufeature.h             |  6 ++++
 arch/arm64/include/asm/memory.h                 |  1 +
 arch/arm64/include/asm/mmu_context.h            | 14 +++++++++
 arch/arm64/include/asm/uaccess.h                | 10 +++++--
 arch/arm64/kernel/cpufeature.c                  | 39 +++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c                   |  2 +-
 arch/arm64/kvm/hyp-init.S                       |  4 +++
 arch/arm64/kvm/hyp/switch.c                     |  6 +++-
 arch/arm64/mm/proc.S                            |  5 ++++
 13 files changed, 104 insertions(+), 5 deletions(-)

-- 
2.0.0
