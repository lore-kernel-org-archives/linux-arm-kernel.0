From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Oct 2014 06:48:56 -0700
Subject: [PATCH v2 0/3] VFP fixes
Message-ID: <1413294539-22069-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes allow us to detect VFP correctly on Krait processors.
They also fix short vector emulation for Cortex-A15 and Krait.

Changes since v1:
 * Move to use CPUID and MVFR0 in patch 2
 * Patches 1 and 3 unchanged

Stepan Moskovchenko (1):
  arm: vfp: Bounce undefined instructions in vectored mode

Stephen Boyd (2):
  ARM: vfp: Workaround bad MVFR1 register on some Kraits
  ARM: vfp: Fix VFPv3 hwcap detection on CPUID based cpus

 arch/arm/include/asm/vfp.h |  5 +++
 arch/arm/mm/proc-v7.S      |  5 ++-
 arch/arm/vfp/vfphw.S       |  6 +++
 arch/arm/vfp/vfpmodule.c   | 93 ++++++++++++++++++++++++++--------------------
 4 files changed, 66 insertions(+), 43 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
