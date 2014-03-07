From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  7 Mar 2014 13:28:04 -0700
Subject: [GIT PULL 1/5] ARM: tegra: Trusted Foundations work for 3.15
Message-ID: <1394224088-28910-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pull request contains a number of cleanups and enhancements for the
Trusted Foundations firmware used on production Tegra SoCs. The changes
allow kernels without TF support to run on HW that uses TF, albeit with
reduced functionality, and also fix the cpuidle feature.

----------------------------------------------------------------

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.15-tf

for you to fetch changes up to 338f2aadca7ed4e30e5937fdebc3ff72fda210b6:

  ARM: tegra: cpuidle: use firmware for power down

----------------------------------------------------------------

Alexandre Courbot (6):
      ARM: trusted_foundations: fix vendor prefix typos
      ARM: trusted_foundations: fallback when TF support is missing
      ARM: firmware: enable Trusted Foundations by default
      ARM: firmware: add prepare_idle() operation
      ARM: trusted_foundations: implement prepare_idle()
      ARM: tegra: cpuidle: use firmware for power down

 arch/arm/firmware/Kconfig                  |  3 ++-
 arch/arm/firmware/trusted_foundations.c    | 20 +++++++++++++++++++-
 arch/arm/include/asm/firmware.h            |  4 ++++
 arch/arm/include/asm/trusted_foundations.h | 13 +++++++++----
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  7 ++++++-
 5 files changed, 40 insertions(+), 7 deletions(-)
