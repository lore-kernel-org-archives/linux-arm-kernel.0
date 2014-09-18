From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Sep 2014 14:43:09 -0700
Subject: [PATCH 0/3] Krait VFP fixes
Message-ID: <1411076592-6157-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes allow us to support VFP correctly on Krait processors.
They also fix short vector emulation for Cortex-A15 and Krait.

Stepan Moskovchenko (1):
  arm: vfp: Bounce undefined instructions in vectored mode

Stephen Boyd (2):
  ARM: vfp: Workaround bad MVFR1 register on some Kraits
  ARM: vfp: fix VFPv3 hwcap detection on non-ARM vfp implementations

 arch/arm/include/asm/cputype.h | 1 +
 arch/arm/include/asm/vfp.h     | 2 +-
 arch/arm/mm/proc-v7.S          | 5 +++--
 arch/arm/vfp/vfphw.S           | 6 ++++++
 arch/arm/vfp/vfpmodule.c       | 7 +++++++
 5 files changed, 18 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
