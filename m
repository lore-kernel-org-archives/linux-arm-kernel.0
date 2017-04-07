From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  7 Apr 2017 14:59:21 +0100
Subject: [PULL] clocksource/arch_timer: Errata workaround infrastructure rework
Message-ID: <20170407135921.17549-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Please find below the pull request for the arm64 architected timer
workaround infrastructure. As discussed on the list, the first 5
patches are shared with the arm64 tree (and the whole branch is stable
anyway).

Thanks,

	M.

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/arch-timer-errata

for you to fetch changes up to d003d029cea8a28139b4f9b88a36b8fac864f45b:

  arm64: arch_timer: Add HISILICON_ERRATUM_161010101 ACPI matching data (2017-04-07 11:22:10 +0100)

----------------------------------------------------------------
arm64 arch timer workaround series, including the base patches
that will also go via the arm64 tree.

----------------------------------------------------------------
Marc Zyngier (18):
      arm64: Allow checking of a CPU-local erratum
      arm64: Add CNTVCT_EL0 trap handler
      arm64: Define Cortex-A73 MIDR
      arm64: cpu_errata: Allow an erratum to be match for all revisions of a core
      arm64: cpu_errata: Add capability to advertise Cortex-A73 erratum 858921
      arm64: arch_timer: Add infrastructure for multiple erratum detection methods
      arm64: arch_timer: Add erratum handler for CPU-specific capability
      arm64: arch_timer: Move arch_timer_reg_read/write around
      arm64: arch_timer: Get rid of erratum_workaround_set_sne
      arm64: arch_timer: Rework the set_next_event workarounds
      arm64: arch_timer: Make workaround methods optional
      arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs
      arm64: arch_timer: Move clocksource_counter and co around
      arm64: arch_timer: Save cntkctl_el1 as a per-cpu variable
      arm64: arch_timer: Enable CNTVCT_EL0 trap if workaround is enabled
      arm64: arch_timer: Workaround for Cortex-A73 erratum 858921
      arm64: arch_timer: Allow erratum matching with ACPI OEM information
      arm64: arch_timer: Add HISILICON_ERRATUM_161010101 ACPI matching data

 Documentation/arm64/silicon-errata.txt |   1 +
 arch/arm64/include/asm/arch_timer.h    |  43 ++-
 arch/arm64/include/asm/cpucaps.h       |   3 +-
 arch/arm64/include/asm/cputype.h       |   2 +
 arch/arm64/include/asm/esr.h           |   2 +
 arch/arm64/kernel/cpu_errata.c         |  15 +
 arch/arm64/kernel/cpufeature.c         |  13 +-
 arch/arm64/kernel/traps.c              |  14 +
 drivers/clocksource/Kconfig            |  11 +
 drivers/clocksource/arm_arch_timer.c   | 535 +++++++++++++++++++++++----------
 10 files changed, 466 insertions(+), 173 deletions(-)
