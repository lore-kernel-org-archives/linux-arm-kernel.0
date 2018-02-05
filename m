From: timur@codeaurora.org (Timur Tabi)
Date: Mon,  5 Feb 2018 14:11:28 -0600
Subject: [PATCH 0/2][for 4.14] Add work-around for Falkor erratum E1041
Message-ID: <1517861490-19395-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches (back-ported from 4.15) implement a work-around for a
rare but serious erratum in Qualcomm Datacenter Technologies Falkor
cores.

One small merge conflict in arch/arm64/Kconfig was resolved when
back-porting patch #2.

P.S. I couldn't find any good examples of submitting a back-ported
patch with resolved merge conflicts to stable at vger.kernel.org, so I
hope I'm not forgetting anything.

Shanker Donthineni (2):
  [for 4.14] arm64: Define cputype macros for Falkor CPU
  [for 4.14] arm64: Add software workaround for Falkor erratum 1041

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 10 ++++++++++
 arch/arm64/include/asm/assembler.h     | 10 ++++++++++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu-reset.S          |  1 +
 arch/arm64/kernel/efi-entry.S          |  2 ++
 arch/arm64/kernel/head.S               |  1 +
 arch/arm64/kernel/relocate_kernel.S    |  1 +
 arch/arm64/kvm/hyp-init.S              |  1 +
 9 files changed, 29 insertions(+)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
