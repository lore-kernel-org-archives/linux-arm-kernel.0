From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  7 Apr 2017 14:44:58 +0100
Subject: [PULL] arm64 pre-requisite patches for timer workarounds
Message-ID: <20170407134458.17151-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Please find below the pull request for the patches forming the base of
my errata workaround series. I expect Daniel to pull the full series
via his tree.

Thanks,

	M.

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/arch-timer-errata-prereq

for you to fetch changes up to eeb1efbcb83c0cfe6d567abbacd675bbddf3d658:

  arm64: cpu_errata: Add capability to advertise Cortex-A73 erratum 858921 (2017-04-07 11:22:08 +0100)

----------------------------------------------------------------
Pre-requisites for the arch timer errata workarounds:

- Allow checking of a CPU-local erratum
- Add CNTVCT_EL0 trap handler
- Define Cortex-A73 MIDR
- Allow an erratum to be match for all revisions of a core
- Add capability to advertise Cortex-A73 erratum 858921

----------------------------------------------------------------
Marc Zyngier (5):
      arm64: Allow checking of a CPU-local erratum
      arm64: Add CNTVCT_EL0 trap handler
      arm64: Define Cortex-A73 MIDR
      arm64: cpu_errata: Allow an erratum to be match for all revisions of a core
      arm64: cpu_errata: Add capability to advertise Cortex-A73 erratum 858921

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/include/asm/esr.h           |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 15 +++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 13 +++++++++++--
 arch/arm64/kernel/traps.c              | 14 ++++++++++++++
 7 files changed, 47 insertions(+), 3 deletions(-)
