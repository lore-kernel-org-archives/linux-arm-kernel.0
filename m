From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 13 May 2015 14:12:45 +0100
Subject: [PATCH v2 0/2] ARM64: consolidate ACPI/DT SMP initialization
Message-ID: <1431522769-11276-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a v2 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/341579.html

v1 -> v2:

- Reinstated/clarified enable-method comment in asm/cpu_ops.h header
- Changed ACPI enable-method error log message
- Changed u32 to __be32 pointer in of_get_cpu_mpidr()

Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>

Lorenzo Pieralisi (2):
  ARM64: kernel: make cpu_ops hooks DT agnostic
  ARM64: kernel: unify ACPI and DT cpus initialization

 arch/arm64/include/asm/acpi.h      |   4 +
 arch/arm64/include/asm/cpu_ops.h   |  27 +++--
 arch/arm64/include/asm/smp.h       |   2 +-
 arch/arm64/kernel/acpi.c           | 124 --------------------
 arch/arm64/kernel/cpu_ops.c        |  72 +++++++-----
 arch/arm64/kernel/cpuidle.c        |   7 +-
 arch/arm64/kernel/psci.c           |  11 +-
 arch/arm64/kernel/setup.c          |   7 +-
 arch/arm64/kernel/smp.c            | 230 ++++++++++++++++++++++++++++---------
 arch/arm64/kernel/smp_spin_table.c |   8 +-
 10 files changed, 257 insertions(+), 235 deletions(-)

-- 
2.2.1
