From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Oct 2013 13:07:58 -0600
Subject: [GIT PULL 3/6] ARM: tegra: core SoC support changes for 3.13
In-Reply-To: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
References: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1382036881-23339-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch includes:
* SoC fuse values are used as device randomness at boot.
* Initial support for the Tegra124 SoC is added. When coupled with an
  appropriate clock driver, which should also be merged for 3.13, we are
  able to boot to user-space using an initrd.
* The powergate code gains support for Tegra114.

This branch is based on previous pull request tegra-for-3.13-cleanup.

----------------------------------------------------------------

The following changes since commit b6bda4e0d23815cb711c16085e03cb23c6d49f21:

  ARM: tegra: fix ARCH_TEGRA_114_SOC select sort order

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.13-soc

for you to fetch changes up to 8d25979dcd10479ebfb9ce01b3c824f4c7659f73:

  ARM: tegra: Add Tegra114 powergate support

----------------------------------------------------------------

Joseph Lo (7):
      ARM: tegra: add Tegra124 SoC support
      ARM: tegra: add PMC compatible value for Tegra124
      ARM: tegra: CPU hotplug support for Tegra124
      ARM: tegra: make tegra_resume can work with current and later chips
      ARM: tegra: enable CPU idle for Tegra124
      ARM: tegra: re-calculate the LP1 data for Tegra30/114
      ARM: tegra: add LP1 support code for Tegra124

Stephen Warren (1):
      ARM: tegra: add fuses as device randomness

Thierry Reding (3):
      ARM: tegra: Remove duplicate powergate defines
      ARM: tegra: Constify list of CPU domains
      ARM: tegra: Add Tegra114 powergate support

 arch/arm/mach-tegra/Kconfig         | 10 +++++-
 arch/arm/mach-tegra/Makefile        |  5 +++
 arch/arm/mach-tegra/cpuidle.c       |  4 ++-
 arch/arm/mach-tegra/flowctrl.c      |  2 ++
 arch/arm/mach-tegra/fuse.c          | 54 ++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/fuse.h          |  1 +
 arch/arm/mach-tegra/hotplug.c       |  2 ++
 arch/arm/mach-tegra/iomap.h         |  3 ++
 arch/arm/mach-tegra/platsmp.c       |  2 ++
 arch/arm/mach-tegra/pm.c            | 12 +++++--
 arch/arm/mach-tegra/pmc.c           |  8 ++---
 arch/arm/mach-tegra/powergate.c     | 48 ++++++++++++++++++++++++++--
 arch/arm/mach-tegra/reset-handler.S | 13 +++-----
 arch/arm/mach-tegra/sleep-tegra30.S | 49 ++++++++++++++++++++++-------
 arch/arm/mach-tegra/tegra.c         |  1 +
 include/linux/tegra-powergate.h     |  9 +++++-
 16 files changed, 188 insertions(+), 35 deletions(-)
