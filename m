From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Mar 2016 22:42:39 +0800
Subject: [PATCH 0/4] ARM: cpuidle: use const and __initconst for cpuidle_ops
Message-ID: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These trivial patches are similar as Masahiro posted in[1]. The main
purpose is let cpuidle_ops structure be constified and replace
"__initdata" with "__initconst".

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/365826.html

Jisheng Zhang (4):
  ARM: cpuidle: add const qualifier to cpuidle_ops member in structures
  ARM: cpuidle: constify return value of arm_cpuidle_get_ops()
  soc: qcom: spm: use const and __initconst for qcom_cpuidle_ops
  drivers: firmware: psci: use const and __initconst for
    psci_cpuidle_ops

 arch/arm/include/asm/cpuidle.h | 2 +-
 arch/arm/kernel/cpuidle.c      | 6 +++---
 drivers/firmware/psci.c        | 2 +-
 drivers/soc/qcom/spm.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.8.0.rc3
