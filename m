From: ykaukab@suse.de (Mian Yousaf Kaukab)
Date: Tue,  7 Aug 2018 20:14:13 +0200
Subject: [PATCH 0/6] arm64: add support for generic cpu vulnerabilities
Message-ID: <20180807181419.15690-1-ykaukab@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GENERIC_CPU_VULNERABILITIES provide a common way to figure out if a
system is affected by vulnerabilities like meltdown and other variants
of spectre. This small series adds support for it in arm64.

Thank you,

Best regards,
Yousaf

Mian Yousaf Kaukab (6):
  arm64: kpti: move check for non-vulnerable CPUs to a function
  arm64: add sysfs vulnerability show for meltdown
  arm64: add sysfs vulnerability show for spectre v1
  arm64: add sysfs vulnerability show for spectre v2
  arm64: add sysfs vulnerability show for speculative store bypass
  arm64: enable generic CPU vulnerabilites support

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cpufeature.h | 16 +++++++
 arch/arm64/kernel/cpu_errata.c      | 84 ++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/cpufeature.c      |  9 +---
 4 files changed, 101 insertions(+), 9 deletions(-)

-- 
2.11.0
